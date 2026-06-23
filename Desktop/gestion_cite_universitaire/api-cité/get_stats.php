<?php


header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Origin: *"); 
header("Content-Type: application/json; charset=UTF-8");
// C:\xampp\htdocs\cite-api\get_stats.php
require 'db.php';

$stats = [
    "occupancy" => 82,
    "payments" => "18k€",
    "pendingRequests" => 55
];

echo json_encode($stats);
?>