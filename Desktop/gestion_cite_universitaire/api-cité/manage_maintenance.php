<?php
require_once 'db.php';
$data = json_decode(file_get_contents("php://input"));
$action = $_GET['action'] ?? 'list';

if ($action === 'list') {
    // On utilise LEFT JOIN pour ne pas perdre de tickets si l'étudiant ou la chambre sont mal liés
    $stmt = $pdo->query("SELECT m.*, s.first_name, s.last_name, r.room_number 
                         FROM maintenance_tickets m 
                         LEFT JOIN students s ON m.student_id = s.id 
                         LEFT JOIN rooms r ON s.room_id = r.id 
                         ORDER BY m.created_at DESC");
    echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC) ?: []);
} elseif ($action === 'submit' && isset($data->student_id)) {
    try {
        $stmt = $pdo->prepare("INSERT INTO maintenance_tickets (student_id, description, status) VALUES (?, ?, 'pending')");
        $success = $stmt->execute([$data->student_id, $data->description]);
        echo json_encode(["success" => $success]);
    } catch (Exception $e) {
        echo json_encode(["success" => false, "message" => $e->getMessage()]);
    }
} elseif ($action === 'update' && isset($data->id)) {
    try {
        $stmt = $pdo->prepare("UPDATE maintenance_tickets SET status = ? WHERE id = ?");
        $success = $stmt->execute([$data->status, $data->id]);
        
        if ($success) {
            $stmt_info = $pdo->prepare("SELECT student_id, description FROM maintenance_tickets WHERE id = ?");
            $stmt_info->execute([$data->id]);
            $ticket = $stmt_info->fetch(PDO::FETCH_ASSOC);
            
            if ($ticket && $ticket['student_id']) {
                $statusLabel = 'en attente';
                if ($data->status === 'in_progress') $statusLabel = 'en cours';
                if ($data->status === 'resolved') $statusLabel = 'traité (en attente de votre validation)';
                if ($data->status === 'validated') $statusLabel = 'clôturé';

                $message = "Maintenance : Votre demande '" . substr($ticket['description'], 0, 20) . "...' est " . $statusLabel . ".";
                $pdo->prepare("INSERT INTO notifications (student_id, message, type) VALUES (?, ?, 'info')")
                    ->execute([$ticket['student_id'], $message]);
            }
        }
        echo json_encode(["success" => $success]);
    } catch (Exception $e) {
        echo json_encode(["success" => false, "message" => $e->getMessage()]);
    }
} elseif ($action === 'validate' && isset($data->id)) {
    $stmt = $pdo->prepare("UPDATE maintenance_tickets SET status = 'validated' WHERE id = ?");
    echo json_encode(["success" => $stmt->execute([$data->id])]);
}
?>
