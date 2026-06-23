<?php
require_once 'db.php';
$data = json_decode(file_get_contents("php://input"));

if ($data && isset($data->id) && isset($data->status)) {
    $stmt = $pdo->prepare("UPDATE students SET status = ? WHERE id = ?");
    $success = $stmt->execute([$data->status, $data->id]);
    echo json_encode(["success" => $success]);
}
?>