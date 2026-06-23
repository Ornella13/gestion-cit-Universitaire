<?php
require_once 'db.php';
$data = json_decode(file_get_contents("php://input"));

if ($data && isset($data->student_id) && isset($data->room_id)) {
    try {
        $pdo->beginTransaction();
        
        // On assigne la chambre
        $stmt = $pdo->prepare("UPDATE students SET room_id = ?, status = 'enrolled' WHERE id = ?");
        $stmt->execute([$data->room_id, $data->student_id]);
        
        // On peut aussi enregistrer une notification pour l'étudiant
        $stmt_notif = $pdo->prepare("INSERT INTO notifications (student_id, message, type) VALUES (?, 'Votre chambre a été attribuée avec succès.', 'success')");
        $stmt_notif->execute([$data->student_id]);
        
        $pdo->commit();
        echo json_encode(["success" => true]);
    } catch (Exception $e) {
        $pdo->rollBack();
        http_response_code(500);
        echo json_encode(["success" => false, "message" => $e->getMessage()]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Données manquantes"]);
}
?>
