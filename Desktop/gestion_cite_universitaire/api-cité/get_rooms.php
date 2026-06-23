<?php
require_once 'db.php';
$building_id = $_GET['building_id'] ?? null;

if ($building_id) {
    try {
        $stmt = $pdo->prepare("SELECT r.*, (SELECT COUNT(*) FROM students s WHERE s.room_id = r.id) as occupants_count FROM rooms r WHERE r.building_id = ?");
        $stmt->execute([$building_id]);
        $rooms = $stmt->fetchAll(PDO::FETCH_ASSOC);
        foreach ($rooms as &$r) {
            $r['id'] = (int)$r['id'];
            $r['building_id'] = (int)$r['building_id'];
            $r['capacity'] = (int)$r['capacity'];
            $r['occupants_count'] = (int)$r['occupants_count'];
        }
        echo json_encode($rooms);
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(["error" => $e->getMessage()]);
    }
} else {
    echo json_encode([]);
}
?>
