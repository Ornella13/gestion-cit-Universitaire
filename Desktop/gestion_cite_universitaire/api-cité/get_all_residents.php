<?php
require_once 'db.php';
$stmt = $pdo->query("SELECT s.*, r.room_number, b.name as building_name 
                    FROM students s 
                    LEFT JOIN rooms r ON s.room_id = r.id 
                    LEFT JOIN buildings b ON r.building_id = b.id 
                    WHERE s.status IN ('enrolled', 'accepted')
                    ORDER BY s.last_name ASC");
echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
?>