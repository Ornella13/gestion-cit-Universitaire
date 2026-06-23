<?php
require_once 'db.php';

$student_id = $_GET['student_id'] ?? null;

if ($student_id) {
    try {
        $stmt = $pdo->prepare("SELECT * FROM notifications WHERE student_id = ? ORDER BY created_at DESC LIMIT 50");
        $stmt->execute([$student_id]);
        echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(["success" => false, "message" => $e->getMessage()]);
    }
} else {
    echo json_encode([]);
}
?>
