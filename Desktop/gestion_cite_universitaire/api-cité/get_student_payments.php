<?php
require_once 'db.php';
$student_id = $_GET['student_id'] ?? null;
if ($student_id) {
    $stmt = $pdo->prepare("SELECT * FROM payments WHERE student_id = ? ORDER BY payment_date DESC");
    $stmt->execute([$student_id]);
    echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC) ?: []);
} else {
    echo json_encode([]);
}
?>
