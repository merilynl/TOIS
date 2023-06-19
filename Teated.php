<?php
require_once "../../config_tarkvaraarendus2023.php";

$conn = new mysqli($GLOBALS["server_host"], $GLOBALS["server_user_name"], $GLOBALS["server_password"], $GLOBALS["database"]);
$conn->set_charset("utf8");
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

$teated_data = array();
  
// Function to query the database for new entries
function kontrolliTeateid($conn) {
    $sql_teated = "SELECT * FROM Teated WHERE Loetud = FALSE ORDER BY Lisamise_aeg DESC";
    $stmt = $conn->prepare($sql_teated);
    $stmt->execute();
    $result = $stmt->get_result();
    global $teated_data;
    

    // Store query results in an array
    if ($result) {
        while ($row = $result->fetch_assoc()) {
            $teated_data[] = $row;
        }
        $stmt->close();
    }

  }
kontrolliTeateid($conn);

  // Check for new entries every 5 minutes
  $interval = 60; 
  $currentTime = time();
  $lastPollTime = isset($_SESSION['lastPollTime']) ? $_SESSION['lastPollTime'] : 0;
  
  if ($currentTime - $lastPollTime >= $interval) {
    kontrolliTeateid($conn);
      $_SESSION['lastPollTime'] = $currentTime;
  }

function loeTeadeteArv($conn) {
  $teadete_arv = 0;

  $query = "SELECT COUNT(ID) AS teadete_arv FROM Teated WHERE Loetud = 0";
  $result = mysqli_query($conn, $query);

  if ($result !== false) { // Check if the query was executed successfully
      $row = mysqli_fetch_assoc($result);
      $teadete_arv = $row["teadete_arv"];
      mysqli_free_result($result);
  }
  
  return $teadete_arv;
}


?>