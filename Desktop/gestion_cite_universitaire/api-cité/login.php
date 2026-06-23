<?php
require_once 'db.php';
$data = json_decode(file_get_contents("php://input"));

if ($data && isset($data->email) && isset($data->password)) {
    $stmt = $pdo->prepare("SELECT * FROM users WHERE email = ?");
    $stmt->execute([$data->email]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($user && $data->password === $user['password']) {
        $name = $user['email'];
        if ($user['role'] === 'student') {
            $stmtS = $pdo->prepare("SELECT first_name, last_name FROM students WHERE email = ?");
            $stmtS->execute([$user['email']]);
            $student = $stmtS->fetch(PDO::FETCH_ASSOC);
            if ($student) $name = $student['first_name'] . ' ' . $student['last_name'];
        }
        echo json_encode(["success" => true, "user" => ["id" => $user['id'], "email" => $user['email'], "role" => $user['role'], "name" => $name]]);
    } else {
        echo json_encode(["success" => false, "message" => "Email ou mot de passe incorrect."]);
    }
}
?>
