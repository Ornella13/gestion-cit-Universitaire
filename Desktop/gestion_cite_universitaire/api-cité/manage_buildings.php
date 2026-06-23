<?php
require_once 'db.php';
$data = json_decode(file_get_contents("php://input"));
$action = $_GET['action'] ?? 'list';

if ($action === 'list') {
    $stmt = $pdo->query("SELECT * FROM buildings");
    $buildings = $stmt->fetchAll(PDO::FETCH_ASSOC);
    foreach ($buildings as &$b) {
        $b['id'] = (int)$b['id'];
    }
    echo json_encode($buildings);
} elseif ($action === 'add' && isset($data->name)) {
    $stmt = $pdo->prepare("INSERT INTO buildings (name) VALUES (?)");
    echo json_encode(["success" => $stmt->execute([$data->name])]);
} elseif ($action === 'update' && isset($data->id)) {
    $stmt = $pdo->prepare("UPDATE buildings SET name = ? WHERE id = ?");
    echo json_encode(["success" => $stmt->execute([$data->name, $data->id])]);
} elseif ($action === 'delete' && isset($_GET['id'])) {
    $stmt = $pdo->prepare("DELETE FROM buildings WHERE id = ?");
    echo json_encode(["success" => $stmt->execute([$_GET['id']])]);
}
?>
