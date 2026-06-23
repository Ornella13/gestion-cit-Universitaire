<?php
require_once 'db.php';
$data = json_decode(file_get_contents("php://input"));

if ($data && (isset($data->student_id) || isset($data->all_unpaid))) {
    try {
        $month = $data->month ?? date('m');
        $year = $data->year ?? date('Y');
        $monthName = date('F', mktime(0, 0, 0, $month, 10));
        
        $message = "RAPPEL : Votre cotisation pour le mois de " . $monthName . " " . $year . " est toujours en attente. Veuillez régulariser votre situation au plus vite.";

        if (isset($data->all_unpaid) && $data->all_unpaid) {
            // Relance groupée
            // On récupère les IDs de ceux qui n'ont pas payé ce mois là
            $stmt_paid = $pdo->prepare("
                SELECT student_id FROM payments 
                WHERE status = 'verifié' AND payment_type = 'monthly' 
                AND MONTH(payment_date) = ? AND YEAR(payment_date) = ?
            ");
            $stmt_paid->execute([$month, $year]);
            $paid_ids = $stmt_paid->fetchAll(PDO::FETCH_COLUMN);
            $paid_ids_str = count($paid_ids) > 0 ? implode(',', $paid_ids) : '0';

            $stmt_unpaid = $pdo->prepare("
                SELECT id FROM students 
                WHERE status = 'enrolled' AND id NOT IN ($paid_ids_str)
            ");
            $stmt_unpaid->execute();
            $unpaid_students = $stmt_unpaid->fetchAll(PDO::FETCH_ASSOC);

            foreach ($unpaid_students as $s) {
                $stmt_notif = $pdo->prepare("INSERT INTO notifications (student_id, message, type) VALUES (?, ?, 'warning')");
                $stmt_notif->execute([$s['id'], $message]);
            }
        } else {
            // Relance individuelle
            $stmt_notif = $pdo->prepare("INSERT INTO notifications (student_id, message, type) VALUES (?, ?, 'warning')");
            $stmt_notif->execute([$data->student_id, $message]);
        }

        echo json_encode(["success" => true]);
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(["success" => false, "message" => $e->getMessage()]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Données manquantes"]);
}
?>
