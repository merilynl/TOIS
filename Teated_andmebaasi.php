<?php
require_once "../../config_tarkvaraarendus2023.php";

$conn = new mysqli($GLOBALS["server_host"], $GLOBALS["server_user_name"], $GLOBALS["server_password"], $GLOBALS["database"]);
$conn->set_charset("utf8");
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$pollingInterval = 60000;

function fetchNewEntryDataAndInsert($sourceTable, $lastFetchedEntry, $conn) {
    $query = "SELECT * FROM " . $sourceTable . " WHERE ID > " . $lastFetchedEntry;
    $result = mysqli_query($conn, $query);

    // Check if the query was successful
    if ($result) {
        // Loop through the rows of the result set
        while ($row = mysqli_fetch_assoc($result)) {
            // Access the values from the source table

            if ($sourceTable == "Oppekava") {
                $liik = "Õppekava";
                $sisu = "Lisati õppekava " . $row['Nimetus'];
            } else if ($sourceTable == "Kursus") {
                $liik = "Kursus";
                $sisu = "Lisati kursus " . $row['Nimetus'];
            }

            // Check if the entry already exists in the "Teated" table
            $checkQuery = "SELECT ID FROM Teated WHERE Liik='$liik' AND Sisu='$sisu'";
            $checkResult = mysqli_query($conn, $checkQuery);
            if (mysqli_num_rows($checkResult) == 0) {

                $insertQuery = "INSERT INTO Teated (Liik, Sisu, Loetud) VALUES ('$liik', '$sisu', 0)";
                mysqli_query($conn, $insertQuery);
            }

            $lastFetchedEntry = $row['ID'];
        }

        mysqli_free_result($result);
    } else {

        echo "Error: " . mysqli_error($conn);
    }

    // Return the last fetched entry for the table
    return $lastFetchedEntry;
}

// Function to fetch new data from all tables and insert into "Teated" table
function fetchAllNewDataAndInsert($lastFetchedEntries, $conn) {
    $lastFetchedEntries['Oppekava'] = fetchNewEntryDataAndInsert("Oppekava", $lastFetchedEntries['Oppekava'], $conn);
    $lastFetchedEntries['Kursus'] = fetchNewEntryDataAndInsert("Kursus", $lastFetchedEntries['Kursus'], $conn);

    return $lastFetchedEntries;
}

// Function to periodically fetch and insert new data
function pollAndInsertNewData($lastFetchedEntries, $conn) {
    global $pollingInterval;
    // Fetch and insert new data initially
    $lastFetchedEntries = fetchAllNewDataAndInsert($lastFetchedEntries, $conn);
    // Return the updated last fetched entries as JSON
    $response = array(
        'success' => true,
        'lastFetchedEntries' => $lastFetchedEntries
    );
}

// Initialize the last fetched entries array with initial values
$lastFetchedEntries = array(
    'Oppekava' => 0,
    'Kursus' => 0,
);

// Call the function to start polling and inserting new data
pollAndInsertNewData($lastFetchedEntries, $conn);

mysqli_close($conn);
?>