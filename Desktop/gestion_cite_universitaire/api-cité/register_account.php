<?php
require_once 'db.php';
$data = json_decode(file_get_contents("php://input"));

if ($data && isset($data->email) && isset($data->password)) {
    try {
        $pdo->beginTransaction();
        $stmt1 = $pdo->prepare("INSERT INTO users (email, password, role) VALUES (?, ?, 'student')");
        $stmt1->execute([$data->email, $data->password]);
        
        // On insère status = 'incomplete' avec le niveau choisi
        $pdo->prepare("INSERT INTO students (email, first_name, last_name, level, status, registration_date) VALUES (?, '', '', ?, 'incomplete', NOW())")
            ->execute([$data->email, $data->level ?? 'L1']);
            
        $pdo->commit();
        echo json_encode(["success" => true]);
    } catch (Exception $e) {
        $pdo->rollBack();
        echo json_encode(["success" => false, "message" => "Erreur: Email peut-être déjà utilisé."]);
    }
}
?>
