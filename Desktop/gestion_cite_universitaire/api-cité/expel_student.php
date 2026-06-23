<?php
require_once 'db.php';
$data = json_decode(file_get_contents("php://input"));

if ($data && isset($data->student_id)) {
    try {
        $pdo->beginTransaction();
        
        // 1. Marquer comme expulsé et libérer la chambre
        $stmt = $pdo->prepare("UPDATE students SET status = 'expelled', room_id = NULL WHERE id = ?");
        $stmt->execute([$data->student_id]);
        
        // 2. Notifier l'étudiant (Notification système interne)
        $stmt_notif = $pdo->prepare("INSERT INTO notifications (student_id, message, type) VALUES (?, ?, 'error')");
        $stmt_notif->execute([
            $data->student_id, 
            "Votre contrat de résidence a été résilié pour non-paiement prolongé. Veuillez libérer les lieux immédiatement."
        ]);
        
        $pdo->commit();
        echo json_encode(["success" => true]);
    } catch (Exception $e) {
        $pdo->rollBack();
        http_response_code(500);
        echo json_encode(["success" => false, "message" => $e->getMessage()]);
    }
} else {
    echo json_encode(["success" => false, "message" => "ID étudiant manquant."]);
}
?>