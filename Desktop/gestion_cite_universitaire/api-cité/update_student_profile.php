<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit;
}

$host = "localhost";
$db_name = "gestion_cite_universitaire";
$username = "root";
$password = "";

try {
    $conn = new PDO("mysql:host=$host;dbname=$db_name", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    echo json_encode(["success" => false, "message" => "Connexion échouée"]);
    exit;
}

$data = json_decode(file_get_contents("php://input"));

if (!empty($data->email)) {
    // Liste des champs autorisés à la mise à jour
    $allowed_fields = ['first_name', 'last_name', 'major', 'photo_url', 'cin_url', 'attestation_url', 'payment_slip_url', 'status'];
    $updates = [];
    $params = [':email' => $data->email];

    foreach ($allowed_fields as $field) {
        if (isset($data->$field)) {
            $updates[] = "$field = :$field";
            $params[":$field"] = $data->$field;
        }
    }

    if (empty($updates)) {
        echo json_encode(["success" => false, "message" => "Rien à mettre à jour."]);
        exit;
    }

    try {
        $sql = "UPDATE students SET " . implode(", ", $updates) . " WHERE email = :email";
        $stmt = $conn->prepare($sql);
        
        if ($stmt->execute($params)) {
             echo json_encode(["success" => true, "message" => "Profil mis à jour."]);
        } else {
             echo json_encode(["success" => false, "message" => "Erreur lors de l'exécution."]);
        }
    } catch(PDOException $e) {
        echo json_encode(["success" => false, "message" => $e->getMessage()]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Email manquant."]);
}
?>