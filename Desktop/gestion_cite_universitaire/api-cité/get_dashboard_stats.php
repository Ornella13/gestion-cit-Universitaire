<?php
require_once 'db.php';

// Statistiques des étudiants (Logés = enrolled)
$total_students = $pdo->query("SELECT COUNT(*) FROM students WHERE status = 'enrolled'")->fetchColumn();

// Demandes en attente (Status pending ou incomplete avec nom rempli)
$pending_requests = $pdo->query("SELECT COUNT(*) FROM students WHERE status IN ('pending', 'incomplete') AND first_name != '' AND first_name IS NOT NULL")->fetchColumn();

// Occupation des chambres
$rooms_data = $pdo->query("SELECT COUNT(*) as total, SUM(capacity) as total_capacity FROM rooms")->fetch(PDO::FETCH_ASSOC);
$total_rooms = $rooms_data['total'] ?: 1;
$total_capacity = $rooms_data['total_capacity'] ?: 1;

$occupied_spots = $pdo->query("SELECT COUNT(*) FROM students WHERE room_id IS NOT NULL")->fetchColumn();
$occupancy_rate = round(($occupied_spots / $total_capacity) * 100);

// Revenus financier (mois en cours)
$monthly_revenue = $pdo->query("SELECT SUM(amount) FROM payments WHERE MONTH(payment_date) = MONTH(CURRENT_DATE) AND YEAR(payment_date) = YEAR(CURRENT_DATE)")->fetchColumn() ?: 0;

// Maintenance active
$active_maint = $pdo->query("SELECT COUNT(*) FROM maintenance_tickets WHERE status NOT IN ('resolved', 'validated')")->fetchColumn() ?: 0;

echo json_encode([
    "total_students" => (int)$total_students,
    "pending_requests" => (int)$pending_requests,
    "room_occupancy" => (int)$occupancy_rate,
    "monthly_revenue" => (float)$monthly_revenue,
    "alerts_count" => (int)$active_maint
]);
?>
