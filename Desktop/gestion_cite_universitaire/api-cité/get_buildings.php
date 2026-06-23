<?php
require_once 'db.php';
$stmt = $pdo->query("SELECT * FROM buildings");
echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
?>