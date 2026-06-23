<?php
require_once 'db.php';

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') { exit; }

$data = json_decode(file_get_contents("php://input"), true);

if (isset($data['student_id']) && isset($data['action'])) {
    $id = $data['student_id'];
    $action = $data['action']; // 'promote' (niveau supérieur) ou 'repeat' (redoubler)

    try {
        if ($action === 'promote') {
            // Passer au niveau suivant et remettre le compteur de redoublement à 0
            $stmt = $pdo->prepare("UPDATE students SET 
                level = CASE 
                    WHEN level = 'L1' THEN 'L2'
                    WHEN level = 'L2' THEN 'L3'
                    WHEN level = 'L3' THEN 'M1'
                    WHEN level = 'M1' THEN 'M2'
                    ELSE 'M2' 
                END,
                repetition_count = 0,
                status = 'pending' 
                WHERE id = ?");
            $stmt->execute([$id]);

            $pdo->prepare("INSERT INTO notifications (student_id, message, type) VALUES (?, 'Félicitations ! Vous avez été promu au niveau supérieur. Veuillez renouveler votre dossier.', 'success')")
                ->execute([$id]);
        } 
        elseif ($action === 'repeat') {
            // Incrémenter le compteur de redoublement
            $stmt = $pdo->prepare("UPDATE students SET repetition_count = repetition_count + 1 WHERE id = ?");
            $stmt->execute([$id]);
            
            // Vérifier si triplant (count >= 2)
            $check = $pdo->prepare("SELECT repetition_count FROM students WHERE id = ?");
            $check->execute([$id]);
            $student = $check->fetch();
            
            if ($student['repetition_count'] >= 2) {
                // Expulsion si triplant
                $expel = $pdo->prepare("UPDATE students SET status = 'expelled', room_id = NULL WHERE id = ?");
                $expel->execute([$id]);

                $pdo->prepare("INSERT INTO notifications (student_id, message, type) VALUES (?, 'Alerte : Vous avez épuisé vos chances de redoublement (triplant). Vous êtes expulsé de la cité universitaire.', 'error')")
                    ->execute([$id]);

                echo json_encode(["success" => true, "status" => "expelled", "message" => "Étudiant triplant : Expulsé"]);
                exit;
            } else {
                // Redoublant autorisé à rester (doit repasser en validation)
                $pdo->prepare("UPDATE students SET status = 'pending' WHERE id = ?")->execute([$id]);
            }
        }

        echo json_encode(["success" => true, "message" => "Dossier mis à jour pour la nouvelle année"]);
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(["success" => false, "message" => $e->getMessage()]);
    }
}
?>
