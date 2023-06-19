<?php
require_once "../../config_tarkvaraarendus2023.php";

$conn = new mysqli($GLOBALS["server_host"], $GLOBALS["server_user_name"], $GLOBALS["server_password"], $GLOBALS["database"]);
$conn->set_charset("utf8");
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Check if the button toggle is pressed
if (isset($_GET['toggle']) && $_GET['toggle'] == "true") {
    $query = "SELECT ID, Liik, Sisu, Loetud FROM Teated WHERE Loetud = 0 ORDER BY Lisamise_aeg DESC";
    $result = mysqli_query($conn, $query);

    // Check if the query was successful
    if ($result) {
        // Fetch all the rows and store them in the array
        $notifications = mysqli_fetch_all($result, MYSQLI_ASSOC);

        // Loop through the notifications array
        foreach ($notifications as $notification) {
            $teate_id = $notification['ID'];
            $liik = $notification['Liik'];
            $sisu = $notification['Sisu'];
            $loetud = $notification['Loetud'];

            // Display the values
            echo "<br>" . $liik . " | " . $sisu . "<br>";
            echo '<div id="loetudContainer">
                <form action="Toolaud.php" method="post">
                    <input type="hidden" name="updateColumn[]" value="' . $teate_id . '">
                    <input type="checkbox" id="loetud_' . $teate_id . '" class="loetud-checkbox" name="loetud_2" value="checkboxValue" onchange="this.form.submit()"';
            if ($loetud) {
                echo ' checked';
            }
            echo '>
                </form>
            </div>';
            echo "<br><hr>";
        }
        if(!empty($notifications)){

        echo '<br>';
        echo '<form action="Toolaud.php" method="post" id="form_read">';
        echo '<input type="checkbox" id="koik_loetud" name="koik_loetud' . '" value="checkboxValue" onchange="this.form.submit()"';
        echo '<label for="koik_loetud" id="label_for_koik_loetud">Märgi kõik loetuks</label>';
        echo '</form><br>';
        }
        mysqli_free_result($result);
    } else {
        echo "Error: " . mysqli_error($conn);
    }
}

// Check if the updateColumn parameter is set
if (isset($_POST['updateColumn'])) {
    if (is_array($_POST['updateColumn'])) {
        foreach ($_POST['updateColumn'] as $teate_id_lugemiseks) {
            $sql = mysqli_prepare($conn, "UPDATE Teated SET Loetud = TRUE WHERE ID = ?");
            mysqli_stmt_bind_param($sql, "i", $teate_id_lugemiseks);
            mysqli_stmt_execute($sql);
            mysqli_stmt_close($sql);
        }
        header("Location: Toolaud.php?notifs_state=visible");
    } else {
        $teate_id_lugemiseks = $_POST['updateColumn'];
        $sql = mysqli_prepare($conn, "UPDATE Teated SET Loetud = TRUE WHERE ID = ?");
        mysqli_stmt_bind_param($sql, "i", $teate_id_lugemiseks);
        mysqli_stmt_execute($sql);

        if (mysqli_stmt_affected_rows($sql) !== false) {
            //echo 'Notification ID ' . $teate_id_lugemiseks . ' updated successfully';  ////////////////////////////////////
            header("Location: Toolaud.php?notifs_state=visible");
            exit(); 
        } else {
            //echo 'Error updating notification ID ' . $teate_id_lugemiseks . ': ' . mysqli_error($conn);
        }

        mysqli_stmt_close($sql);
        header("Location: Toolaud.php?notifs_state=visible");
        exit(); 
    }
    if (isset($_GET['notifs_state']) && $_GET['notifs_state'] == "visible") {
        echo("testing");
        $notif_state = "hidden";
        header("Location: Toolaud.php?notifs_state=hidden");
    }
}

if (isset($_POST['koik_loetud'])) {
    $sql = "UPDATE Teated SET Loetud = TRUE WHERE Loetud = FALSE";
    $stmt = $conn->prepare($sql);
    if ($stmt) {
        $stmt->execute();
        if ($stmt->affected_rows >= 0) {
            echo "Teated on märgitud loetuks.";
        } else {
            echo "Teateid ei õnnestunud märkida loetuks.";
        }
    } else {
        echo "Statement preparation failed: " . $conn->error;
    }
    header("Location: Toolaud.php?notifs_state=visible");
    exit();
}

mysqli_close($conn);
?>