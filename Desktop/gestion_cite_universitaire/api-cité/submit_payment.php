<?php
require_once 'db.php';
$data = json_decode(file_get_contents("php://input"));

if ($data && isset($data->student_id) && isset($data->amount)) {
    try {
        $stmt = $pdo->prepare("INSERT INTO payments (student_id, amount, payment_type, payment_date, slip_url) VALUES (?, ?, ?, NOW(), ?)");
        $success = $stmt->execute([
            $data->student_id, 
            $data->amount, 
            $data->payment_type ?? 'monthly', 
            $data->slip_url ?? null
        ]);
        echo json_encode(["success" => $success, "message" => $success ? "Paiement enregistré" : "Échec de l'insertion"]);
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(["success" => false, "message" => "Erreur SQL: " . $e->getMessage()]);
    }
} else {
    http_response_code(400);
    echo json_encode(["success" => false, "message" => "Données incomplètes (student_id et amount requis)."]);
}