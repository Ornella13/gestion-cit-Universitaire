<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

// On désactive l'affichage des erreurs pour éviter de polluer le JSON en cas de notice
error_reporting(0);
ini_set('display_errors', 0);

$host = "localhost";
$db_name = "gestion_cite_universitaire";
$username = "root";
$password = "";

try {
    $pdo = new PDO("mysql:host=" . $host . ";dbname=" . $db_name, $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->exec("set names utf8");
} catch(PDOException $e) {
    http_response_code(500);
    echo json_encode(["success" => false, "message" => "Erreur de base de données : " . $e->getMessage()]);
    exit();
}
?>
