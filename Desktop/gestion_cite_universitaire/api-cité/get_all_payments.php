<?php
require_once 'db.php';
try {
    $stmt = $pdo->query("SELECT p.*, s.first_name, s.last_name, s.email FROM payments p LEFT JOIN students s ON p.student_id = s.id ORDER BY p.payment_date DESC");
    echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC) ?: []);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["error" => $e->getMessage()]);
}
?>
