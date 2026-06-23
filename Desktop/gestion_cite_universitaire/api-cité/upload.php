<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') { exit; }

$target_dir = "uploads/";
if (!file_exists($target_dir)) { mkdir($target_dir, 0777, true); }

$file = $_FILES['file'];
$type = $_POST['type'];
$email = str_replace(['@', '.'], '', $_POST['email']);
$filename = $type . "_" . time() . "_" . $email . "." . pathinfo($file['name'], PATHINFO_EXTENSION);
$target_file = $target_dir . $filename;

if (move_uploaded_file($file['tmp_name'], $target_file)) {
    $url = "http://localhost/api-cit%C3%A9/" . $target_file;
    echo json_encode(["success" => true, "url" => $url]);
} else {
    echo json_encode(["success" => false, "message" => "Erreur lors du téléchargement"]);
}
?>