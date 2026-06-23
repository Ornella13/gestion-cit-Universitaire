<?php
require_once 'db.php';
$stmt = $pdo->query("SELECT * FROM students ORDER BY registration_date DESC");
echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC) ?: []);
?>
