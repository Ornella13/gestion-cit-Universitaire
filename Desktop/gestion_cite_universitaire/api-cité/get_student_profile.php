<?php
require_once 'db.php';
if (isset($_GET['email'])) {
    $stmt = $pdo->prepare("SELECT * FROM students WHERE email = ?");
    $stmt->execute([$_GET['email']]);
    $student = $stmt->fetch(PDO::FETCH_ASSOC);
    echo json_encode($student ?: null);
} else {
    echo json_encode(null);
}
?>
