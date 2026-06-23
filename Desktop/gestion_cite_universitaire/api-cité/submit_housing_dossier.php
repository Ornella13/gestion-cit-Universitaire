<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit;
}

// Connexion à la base de données
$host = "localhost";
$db_name = "gestion_cite_universitaire";
$username = "root";
$password = "";

try {
    $conn = new PDO("mysql:host=$host;dbname=$db_name", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    echo json_encode(["success" => false, "message" => "Erreur de connexion : " . $e->getMessage()]);
    exit;
}

// Récupération des données JSON
$data = json_decode(file_get_contents("php://input"));

if (!empty($data->studentEmail)) {
    // Vérification que le bordereau est présent
    if (empty($data->payment_slip_url)) {
        echo json_encode(["success" => false, "message" => "Le bordereau de versement est obligatoire."]);
        exit;
    }

    try {
        $query = "UPDATE students SET 
                    first_name = :first_name,
                    last_name = :last_name,
                    major = :major,
                    is_repeating = :is_repeating,
                    photo_url = :photo_url,
                    cin_url = :cin_url,
                    attestation_url = :attestation_url,
                    payment_slip_url = :payment_slip_url,
                    status = 'pending' 
                  WHERE email = :email";

        $stmt = $conn->prepare($query);

        // Liaison des paramètres
        $stmt->bindParam(':first_name', $data->first_name);
        $stmt->bindParam(':last_name', $data->last_name);
        $stmt->bindParam(':major', $data->major);
        $stmt->bindParam(':is_repeating', $data->is_repeating, PDO::PARAM_INT);
        $stmt->bindParam(':photo_url', $data->photo_url);
        $stmt->bindParam(':cin_url', $data->cin_url);
        $stmt->bindParam(':attestation_url', $data->attestation_url);
        $stmt->bindParam(':payment_slip_url', $data->payment_slip_url);
        $stmt->bindParam(':email', $data->studentEmail);

        if ($stmt->execute()) {
            echo json_encode(["success" => true, "message" => "Dossier soumis avec succès."]);
        } else {
            echo json_encode(["success" => false, "message" => "Erreur lors de la mise à jour."]);
        }
    } catch(PDOException $e) {
        echo json_encode(["success" => false, "message" => "Erreur SQL : " . $e->getMessage()]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Données incomplètes (Email manquant)."]);
}
?>