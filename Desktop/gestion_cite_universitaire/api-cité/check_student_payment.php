<?php
require_once 'db.php';

$student_email = $_GET['email'] ?? null;

if (!$student_email) {
    echo json_encode(["status" => "error", "message" => "Email manquant"]);
    exit;
}

try {
    // Trouver l'ID de l'étudiant
    $stmt_s = $pdo->prepare("SELECT id FROM students WHERE email = ?");
    $stmt_s->execute([$student_email]);
    $student = $stmt_s->fetch();

    if (!$student) {
        echo json_encode(["status" => "error", "message" => "Étudiant non trouvé"]);
        exit;
    }

    $month = date('m');
    $year = date('Y');

    // Vérifier le paiement pour le mois en cours
    $stmt_check = $pdo->prepare("
        SELECT id, status 
        FROM payments 
        WHERE student_id = ? 
        AND payment_type = 'monthly' 
        AND MONTH(payment_date) = ? 
        AND YEAR(payment_date) = ?
        LIMIT 1
    ");
    $stmt_check->execute([$student['id'], $month, $year]);
    $payment = $stmt_check->fetch();

    if ($payment) {
        echo json_encode([
            "has_paid" => true,
            "status" => $payment['status']
        ]);
    } else {
        echo json_encode([
            "has_paid" => false
        ]);
    }
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["status" => "error", "message" => $e->getMessage()]);
}
?>
