<?php
require_once 'db.php';
$data = json_decode(file_get_contents("php://input"));
$action = $_GET['action'] ?? 'list';

if ($action === 'list' && isset($_GET['building_id'])) {
    $stmt = $pdo->prepare("SELECT r.*, (SELECT COUNT(*) FROM students s WHERE s.room_id = r.id) as occupants_count FROM rooms r WHERE r.building_id = ?");
    $stmt->execute([$_GET['building_id']]);
    $rooms = $stmt->fetchAll(PDO::FETCH_ASSOC);
    foreach ($rooms as &$r) {
        $r['id'] = (int)$r['id'];
        $r['building_id'] = (int)$r['building_id'];
        $r['capacity'] = (int)$r['capacity'];
        $r['occupants_count'] = (int)$r['occupants_count'];
    }
    echo json_encode($rooms);
} elseif ($action === 'list_all') {
    $stmt = $pdo->query("SELECT r.*, (SELECT COUNT(*) FROM students s WHERE s.room_id = r.id) as occupants_count FROM rooms r");
    $rooms = $stmt->fetchAll(PDO::FETCH_ASSOC);
    foreach ($rooms as &$r) {
        $r['id'] = (int)$r['id'];
        $r['building_id'] = (int)$r['building_id'];
        $r['capacity'] = (int)$r['capacity'];
        $r['occupants_count'] = (int)$r['occupants_count'];
    }
    echo json_encode($rooms);
} elseif ($action === 'add' && isset($data->room_number)) {
    $stmt = $pdo->prepare("INSERT INTO rooms (building_id, room_number, capacity, maintenance_status) VALUES (?, ?, ?, 'ok')");
    echo json_encode(["success" => $stmt->execute([$data->building_id, $data->room_number, $data->capacity ?? 4])]);
} elseif ($action === 'bulk_add' && isset($data->count)) {
    $count = (int)$data->count;
    $building_id = (int)$data->building_id;
    
    $stmt_last = $pdo->prepare("SELECT room_number FROM rooms WHERE building_id = ? ORDER BY id DESC LIMIT 1");
    $stmt_last->execute([$building_id]);
    $last_val = $stmt_last->fetchColumn();
    $last_num = $last_val ? (int)preg_replace('/[^0-9]/', '', $last_val) : 0;
    
    $stmt = $pdo->prepare("INSERT INTO rooms (building_id, room_number, capacity, maintenance_status) VALUES (?, ?, 4, 'ok')");
    $success = true;
    for ($i = 1; $i <= $count; $i++) {
        $next_num = $last_num + $i;
        $room_name = str_pad($next_num, 3, '0', STR_PAD_LEFT);
        if (!$stmt->execute([$building_id, $room_name])) $success = false;
    }
    echo json_encode(["success" => $success]);
} elseif ($action === 'update' && isset($data->id)) {
    $stmt = $pdo->prepare("UPDATE rooms SET room_number = ?, capacity = ? WHERE id = ?");
    echo json_encode(["success" => $stmt->execute([$data->room_number, $data->capacity, $data->id])]);
} elseif ($action === 'delete' && isset($_GET['id'])) {
    $stmt = $pdo->prepare("DELETE FROM rooms WHERE id = ?");
    echo json_encode(["success" => $stmt->execute([$_GET['id']])]);
}
?>
