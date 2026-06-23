<?php
require_once 'db.php';

try {
    $month = $_GET['month'] ?? date('m');
    $year = $_GET['year'] ?? date('Y');

    // Récupérer tous les étudiants actifs (enrolled)
    $stmt_students = $pdo->query("SELECT id, first_name, last_name, email, registration_date FROM students WHERE status = 'enrolled'");
    $all_students = $stmt_students->fetchAll(PDO::FETCH_ASSOC);

    // Récupérer tous les paiements vérifiés pour ce mois et cette année
    $stmt_paid = $pdo->prepare("
        SELECT student_id 
        FROM payments 
        WHERE status = 'verifié' 
        AND payment_type = 'monthly' 
        AND MONTH(payment_date) = ? 
        AND YEAR(payment_date) = ?
    ");
    $stmt_paid->execute([$month, $year]);
    $paid_ids = $stmt_paid->fetchAll(PDO::FETCH_COLUMN);

    $report = [
        "paid" => [],
        "unpaid" => []
    ];

    // Mois précédent pour calcul consécutif
    $prev_month = (int)$month - 1;
    $prev_year = (int)$year;
    if ($prev_month === 0) {
        $prev_month = 12;
        $prev_year--;
    }

    // Préparer la requête pour vérifier le mois précédent
    $stmt_prev_paid = $pdo->prepare("
        SELECT COUNT(*) 
        FROM payments 
        WHERE student_id = ? 
        AND status = 'verifié' 
        AND payment_type = 'monthly' 
        AND MONTH(payment_date) = ? 
        AND YEAR(payment_date) = ?
    ");

    foreach ($all_students as $student) {
        if (in_array($student['id'], $paid_ids)) {
            $report['paid'][] = $student;
        } else {
            // Initialiser consecutive_unpaid par défaut à 1
            $consecutive_unpaid = 1;
            
            // Calculer s'il y a plus d'un mois impayé
            if (!empty($student['registration_date'])) {
                $reg_date = new DateTime($student['registration_date']);
                $prev_month_first_day = new DateTime(sprintf("%04d-%02d-01", $prev_year, $prev_month));
                $reg_month_first_day = new DateTime($reg_date->format('Y-m-01'));
                
                // Si le mois précédent est supérieur ou égal au mois d'inscription, on vérifie s'il a été payé
                if ($prev_month_first_day >= $reg_month_first_day) {
                    $stmt_prev_paid->execute([$student['id'], $prev_month, $prev_year]);
                    $has_paid_prev = $stmt_prev_paid->fetchColumn() > 0;
                    if (!$has_paid_prev) {
                        $consecutive_unpaid = 2;
                    }
                }
            }
            
            $student['consecutive_unpaid'] = $consecutive_unpaid;
            $report['unpaid'][] = $student;
        }
    }

    echo json_encode($report);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["error" => $e->getMessage()]);
}
?>