<?php
require_once 'db.php';

// Autoriser les requêtes depuis le frontend
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit;
}

$data = json_decode(file_get_contents("php://input"), true);

if (isset($data['payment_id']) && isset($data['status'])) {
    try {
        // On s'assure d'utiliser les termes exacts de la base de données
        if ($data['status'] === 'rejected') {
            // Récupérer le student_id, le montant et la date pour la notification avant de supprimer la transaction
            $stmt_p = $pdo->prepare("SELECT student_id, amount, payment_date FROM payments WHERE id = ?");
            $stmt_p->execute([$data['payment_id']]);
            $payment = $stmt_p->fetch(PDO::FETCH_ASSOC);
            
            $success = false;
            if ($payment) {
                // Déterminer le mois à notifier
                $month_info = "";
                if (!empty($payment['payment_date'])) {
                    $date_obj = new DateTime($payment['payment_date']);
                    $months_fr = [
                        1 => 'Janvier', 2 => 'Février', 3 => 'Mars', 4 => 'Avril', 
                        5 => 'Mai', 6 => 'Juin', 7 => 'Juillet', 8 => 'Août', 
                        9 => 'Septembre', 10 => 'Octobre', 11 => 'Novembre', 12 => 'Décembre'
                    ];
                    $month_num = (int)$date_obj->format('n');
                    $month_info = " (" . $months_fr[$month_num] . " " . $date_obj->format('Y') . ")";
                }
                
                $msg = "Votre paiement de " . number_format($payment['amount'], 0, '', ' ') . " Ar" . $month_info . " a été REFUSÉ par l'administration. Veuillez vérifier votre bordereau.";
                $notif = $pdo->prepare("INSERT INTO notifications (student_id, message, type) VALUES (?, ?, 'error')");
                $notif->execute([$payment['student_id'], $msg]);
                
                // Supprimer la transaction
                $stmt_del = $pdo->prepare("DELETE FROM payments WHERE id = ?");
                $success = $stmt_del->execute([$data['payment_id']]);
            }
        } else {
            // On s'assure d'utiliser les termes exacts de la base de données
            if ($data['status'] === 'verified') {
                $status = 'verifié';
            } else {
                $status = 'attent';
            }
            $stmt = $pdo->prepare("UPDATE payments SET status = ? WHERE id = ?");
            $success = $stmt->execute([$status, $data['payment_id']]);
            
            if ($success) {
                // Récupérer le student_id pour la notification
                $stmt_p = $pdo->prepare("SELECT student_id, amount, payment_date FROM payments WHERE id = ?");
                $stmt_p->execute([$data['payment_id']]);
                $payment = $stmt_p->fetch(PDO::FETCH_ASSOC);
                
                if ($payment && $status === 'verifié') {
                    // Déterminer le mois à notifier
                    $month_info = "";
                    if (!empty($payment['payment_date'])) {
                        $date_obj = new DateTime($payment['payment_date']);
                        $months_fr = [
                            1 => 'Janvier', 2 => 'Février', 3 => 'Mars', 4 => 'Avril', 
                            5 => 'Mai', 6 => 'Juin', 7 => 'Juillet', 8 => 'Août', 
                            9 => 'Septembre', 10 => 'Octobre', 11 => 'Novembre', 12 => 'Décembre'
                        ];
                        $month_num = (int)$date_obj->format('n');
                        $month_info = " (" . $months_fr[$month_num] . " " . $date_obj->format('Y') . ")";
                    }
                    
                    $msg = "Votre paiement de " . number_format($payment['amount'], 0, '', ' ') . " Ar" . $month_info . " a été validé par l'administration.";
                    $notif = $pdo->prepare("INSERT INTO notifications (student_id, message, type) VALUES (?, ?, 'success')");
                    $notif->execute([$payment['student_id'], $msg]);
                }
            }
        }
        
        echo json_encode([
            "success" => $success, 
            "message" => $success ? "Paiement mis à jour" : "Échec de la mise à jour"
        ]);
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(["success" => false, "message" => $e->getMessage()]);
    }
} else {
    http_response_code(400);
    echo json_encode(["success" => false, "message" => "Données manquantes"]);
}
?>
