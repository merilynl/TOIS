<!-- KASUTAJA: kasutajanimi - test; parool - test -->

<?php
//require("Toolaud_php.php");
require_once "../../config_tarkvaraarendus2023.php";
include "Teated.php";
include "Teated_koik.php";
include "Teated_andmebaasi.php";

$conn = new mysqli($GLOBALS["server_host"], $GLOBALS["server_user_name"], $GLOBALS["server_password"], $GLOBALS["database"]);
$conn->set_charset("utf8");
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

pollAndInsertNewData($lastFetchedEntries, $conn);
?>


<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Töölaud</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="Toolaud.css">
</head>
<body>
    <div id="header">
        <div id="tlu_logo">
            <img src="img/TLU_logo.jpg" id="tlu_logo_img">
        </div>
        <div id="help_logout">
                <div id="kasutusjuhend">
                    <a href="KasutusjuhendPP.html">
                    <button id="help_btn"> ?
                    </button>
                    </a>
                </div>
                <a href="Login.php"> <button class="logout-button">Logi välja</button> </a>
        </div>
        <hr>
        <div id="home">
            <button id="home_btn">
                <img src="img/home_btn.png" id="home_btn_img">
            </button>
        </div>
        <hr>
    </div>
    <div id="notifications">
        <button id="notif_btn">
            <img src="img/teated_btn.png" id="notif_btn_img">
            <?php if(loeTeadeteArv($conn) > 0){?>
            <span class="notif_bubble" id="notif_bubble"><?php echo loeTeadeteArv($conn); ?></span>
            <?php } ?>
        </button>
        
<div id="notifs">
    <ul>
        <?php if(!empty($teated_data)){ 
            ?>
            <li>
                <div id="esimeneTeade"><?php echo $teated_data[0]["Liik"] . " | " . $teated_data[0]["Sisu"]; ?></div>
                
                <div id="loetudContainer">
                    <form action="<?php echo $_SERVER['PHP_SELF']; ?>" method="post">
                        <label for="loetud">Loetud</label>
                        <input type="hidden" name="updateColumn[]" value="<?php echo $teated_data[0]["ID"] ?>">
                        <input type="checkbox" id="loetud" name="updateColumn" value="<?php echo $teated_data[0]["ID"] ?>" onchange="this.form.submit()" <?php if(!isset($_POST['updateColumn'])){echo '';}?>>
                        <!-- name="loetud" -->
                    </form>
                </div>
                <br>
                <button id="toggle_button" onclick="toggleTeated();">Vaata kõiki teateid</button>
                <div id="teated_result" style="display: none;"></div>  
            </li>
        <?php } else { ?> 
            <li>Teateid pole</li>
            <div id="teated_result" style="display: none;"></div>
        <?php }; ?>
    </ul>
</div>

    </div>
<script src="Toolaud.js"></script>
<div class="grid-container">
<!-- ÕPPEKAVAD -->
<div class="grid-item">
  <h2>ÕPPEKAVAD</h2>

  <?php
    $query1 = "SELECT Oppekava.Oppekava_kood, Oppekava.Nimetus, DATE_FORMAT(Oppekava.Sisestamise_kuupaev, '%d.%m.%Y') AS FormattedDate, Oppekava.Staatus FROM Oppekava ORDER BY Oppekava.Sisestamise_kuupaev DESC";
    $result1 = mysqli_query($conn, $query1);
    $rowCount1 = mysqli_num_rows($result1);
    $displayLimit1 = 5; 

    if ($rowCount1 > 0) {
      $sn = 1;
    ?>
    <table>
    <tr class="table_row">
        <th scope="col" class="text_data box_width">Õppekava kood</th>
        <th scope="col" class="text_data">Õppekava nimetus</th>
        <th scope="col" class="number_data number_data_exception">Sisestamise kuupäev</th>
        <th scope="col" class="text_data text_data_exception box_width" >Staatus</th>
        <th scope="col" class="text_data box_width"></th>
    </tr>
    <?php
    $rowCounter = 0;
    while ($data = mysqli_fetch_assoc($result1)) {
    ?>
    <tr class="resultRow1" <?php if ($rowCounter >= $displayLimit1) { echo 'style="display: none;"'; } ?>>
        <td class="text_data box_width"><?php echo $data['Oppekava_kood']; ?></td>
        <td class="text_data"><?php echo $data['Nimetus']; ?></td>
        <td class="number_data date"><?php echo $data['FormattedDate']; ?></td>
        <td class="text_data text_data_exception box_width"><?php echo $data['Staatus']; ?></td>
        <td class="text_data box_width"><a href="Oppekava/<?php echo $data['Oppekava_kood']; ?>.php">
            <?php if ($data['Staatus'] == 'Lukustatud') {
            echo "Vaata õppekava";
            } else if($data['Staatus'] == 'Kinnitamisel') {
            echo "Vaata õppekava";
            } else {
            echo "Muuda õppekava";
            } ?>
        </a></td>
    </tr>
    <?php
    $rowCounter++;
    if ($rowCounter == $displayLimit1 && $rowCount1 > $displayLimit1) {
        ?>
        <tr id="showMoreRow1">
        <td colspan="5" style="text-align: center;">
            <button class="button" onclick="showMore1()">Vaata veel</button>
        </td>
        </tr>
        <?php
    }
    $sn++;
    }
    ?>
    <tr id="hideMoreRow1" style="display: none;">
        <td colspan="5" style="text-align: center;">
        <button class="button" onclick="hideMore1()">Peida</button>
        </td>
    </tr>
    </table>
    <?php
    } else {
    ?>
    <p>Õppekavad puuduvad</p>
    <?php
    }
  ?>
</div>
  <script>
        var displayLimit1 = <?php echo $displayLimit1; ?>;
        var resultRows1 = document.getElementsByClassName('resultRow1');
        var showMoreRow1 = document.getElementById('showMoreRow1');
        var hideMoreRow1 = document.getElementById('hideMoreRow1');

        function showMore1() {
            for (var i = displayLimit1; i < resultRows1.length; i++) {
            resultRows1[i].style.display = 'table-row';
            }
            showMoreRow1.style.display = 'none';
            hideMoreRow1.style.display = 'table-row';
        }

        function hideMore1() {
            for (var i = displayLimit1; i < resultRows1.length; i++) {
            resultRows1[i].style.display = 'none';
            }
            showMoreRow1.style.display = 'table-row';
            hideMoreRow1.style.display = 'none';
        }
  </script>

<!-- ARVED -->
<div class="grid-item">
    <h2>MAKSMATA ARVED</h2>
    <?php
    $query2 = "SELECT DISTINCT Opilane.Nimi, Arve.Arve_number, DATE_FORMAT(Arve.Maksetahtaeg, '%d.%m.%Y') AS FormattedDate, Kursus.Nimetus, Kursus.Kursuse_kood FROM Arve LEFT JOIN Opilane ON Opilane.ID = Arve.Opilane_ID LEFT JOIN Kursus ON Arve.Kursus_ID = Kursus.ID LEFT JOIN Opilane_kursus ON Opilane.ID = Opilane_kursus.Opilane_ID AND Kursus.ID = Opilane_kursus.Kursus_ID WHERE Arve.Maksetahtaeg < CURRENT_TIMESTAMP AND Arve.Staatus = 'Maksmata' GROUP BY Arve.Arve_number ORDER BY Arve.Maksetahtaeg, Arve.Arve_number LIMIT 5";
    $result2 = mysqli_query($conn, $query2);
    $displayLimit2 = 5; 
    ?>
    <table>
    <tr class="table_row">
        <th scope="col" class="text_data box_width">Linastuse kood</th>
        <th scope="col" class="text_data">Kursuse nimetus</th>
        <th scope="col" class="text_data">Maksja nimi</th>
        <th scope="col" class="number_data">Arve nr</th>
        <th scope="col" class="number_data number_data_exception">Maksetähtaeg</th>
    </tr>
    <?php
        if (mysqli_num_rows($result2) > 0) {
        $sn=1;
        $rowCounter = 0;
        while($data2 = mysqli_fetch_assoc($result2)) {
    ?>
    <tr class="resultRow2" <?php if ($rowCounter >= $displayLimit2) { echo 'style="display: none;"'; } ?>>
        <td class="text_data box_width"><?php echo $data2['Kursuse_kood']; ?></td>
        <td class="text_data"><a href="Kursus/<?php echo $data2['Kursuse_kood']; ?>.php" ><?php echo $data2['Nimetus']; ?></a></td>
        <td class="text_data"><?php echo $data2['Nimi']; ?></td>
        <td class="number_data"><a href="Arve/<?php echo $data2['Arve_number']; ?>.php" ><?php echo $data2['Arve_number']; ?></a></td>
        <td class="number_data date"><?php echo $data2['FormattedDate']; ?></td>
    </tr>
    <?php
    $rowCounter++;
    if ($rowCounter == $displayLimit2 && mysqli_num_rows($result2) > $displayLimit2) {
    ?>
    <tr id="showMoreRow2">
        <td colspan="5" style="text-align: center;">
        <button class="button" onclick="showMore2()">Vaata veel</button>
        </td>
    </tr>
    <?php
    }
    $sn++;
        }
    ?>
    <tr id="hideMoreRow2" style="display: none;">
        <td colspan="5" style="text-align: center;">
        <button class="button" onclick="hideMore2()">Peida</button>
        </td>
    </tr>
    <?php
    } else {
    ?>
    <tr>
    <td colspan="5">Maksmata arved puuduvad</td>
    </tr>
    <?php
    }
    ?>
    </table> 
</div>

<script>
    var displayLimit2 = <?php echo $displayLimit2; ?>;
    var resultRows2 = document.getElementsByClassName('resultRow2');
    var showMoreRow2 = document.getElementById('showMoreRow2');
    var hideMoreRow2 = document.getElementById('hideMoreRow2');

    function showMore2() {
        for (var i = displayLimit2; i < resultRows2.length; i++) {
        resultRows2[i].style.display = 'table-row';
        }
        showMoreRow2.style.display = 'none';
        hideMoreRow2.style.display = 'table-row';
    }

    function hideMore2() {
        for (var i = displayLimit2; i < resultRows2.length; i++) {
        resultRows2[i].style.display = 'none';
        }
        showMoreRow2.style.display = 'table-row';
        hideMoreRow2.style.display = 'none';
    }
</script>

<!-- ALGAVAD KURSUSED -->
<div class="grid-item">
    <table id="table3">
    <h2>ALGAVAD KURSUSED</h2>
                
    <table>
    <tr class="table_row">
        <th scope="col" class="text_data box_width">Linastuse kood</th>
        <th scope="col" class="text_data">Kursuse nimetus</th>
        <th scope="col" class="number_data date">Linastus</th>
        <th scope="col" class="number_data box_width">Kursusele registreerunud</th>
        <th scope="col" class="number_data box_width">Koostamata arved</th>
    </tr>
    <?php

    $stmt1 = mysqli_prepare($conn, "SELECT DISTINCT Kursus.Kursuse_kood FROM Kursus LEFT JOIN Opilane_kursus ON Kursus.ID = Opilane_kursus.Kursus_ID LEFT JOIN Opilane ON Opilane_kursus.Opilane_ID = Opilane.ID LEFT JOIN Arve ON Opilane.ID = Arve.Opilane_ID AND Kursus.ID = Arve.Kursus_ID WHERE Kursus.Alguse_aeg >= CURRENT_DATE() AND Kursus.Alguse_aeg <= DATE_ADD(CURRENT_DATE(), INTERVAL 8 DAY) ORDER BY Kursus.Alguse_aeg, Kursus.Nimetus");
    mysqli_stmt_bind_result($stmt1, $kursuse_kood_from_db);
    $stmt1->execute();
    $result3 = $stmt1->get_result();
    $rows = $result3->fetch_all(MYSQLI_ASSOC);
    //var_dump($rows);
    if(!empty($rows)){
        $rowCount = count($rows);
        $displayLimit = 5; 

    for($x = 0; $x < count($rows); $x++){
        $kursuse_kood = $rows[$x]['Kursuse_kood'];

        $stmt2 = mysqli_prepare($conn, "SELECT
        COUNT(DISTINCT Opilane_kursus.Opilane_ID) AS Osalevad_opilased,
        (COUNT(DISTINCT Opilane_kursus.Opilane_ID) - COUNT(DISTINCT Arve.Opilane_ID)) AS Koostamata_arved,
        Kursus.Nimetus,
        Kursus.Kursuse_kood, 
        DATE_FORMAT(Kursus.Alguse_aeg, '%d.%m.%Y') AS FormattedDate,
        Kursus.MAX_osalejad
        FROM Kursus
        LEFT JOIN Opilane_kursus ON Kursus.ID = Opilane_kursus.Kursus_ID
        LEFT JOIN Opilane ON Opilane_kursus.Opilane_ID = Opilane.ID
        LEFT JOIN Arve ON Opilane.ID = Arve.Opilane_ID AND Kursus.ID = Arve.Kursus_ID
        WHERE Kursus.Kursuse_kood = ?
        GROUP BY Kursus.Nimetus, Kursus.Kursuse_kood, Kursus.Alguse_aeg, Kursus.MAX_osalejad;");
        mysqli_stmt_bind_param($stmt2, "s", $kursuse_kood);
        $stmt2->execute();
        $result4 = $stmt2->get_result();
        $rows2 = $result4->fetch_all(MYSQLI_ASSOC);

        if (!empty($rows2)) {
            $osalevad = $rows2[0];
    ?>
            <tr class="resultRow" <?php if ($x >= $displayLimit) echo 'style="display: none;"'; ?>>
                <td class="text_data box_width"><?php echo $osalevad['Kursuse_kood']; ?></td>
                <td class="text_data"><a href="Kursus/<?php echo $osalevad['Kursuse_kood']; ?>.php"><?php echo $osalevad['Nimetus']; ?></a></td>
                <td class="number_data date"><?php echo $osalevad['FormattedDate']; ?></td>
                <td class="number_data number_data_exception box_width"><?php echo $osalevad["Osalevad_opilased"]; ?>/<?php echo $osalevad["MAX_osalejad"]; ?></td>
                <td class="number_data number_data_exception box_width"><?php echo $osalevad['Koostamata_arved']; ?></td>
            </tr>
    <?php
        } else {
    ?>
            <tr class="resultRow" <?php if ($x >= $displayLimit) echo 'style="display: none;"'; ?>>
                <td colspan="5">Algavad kursused puuduvad</td>
            </tr>
    <?php
        }
    }

    if ($rowCount > $displayLimit) {
    ?>
    <tr id="showMoreRow">
        <td colspan="5"><button class="button" onclick="showMore()">Vaata veel</button></td>
    </tr>
    <tr id="hideMoreRow" style="display: none;">
        <td colspan="5"><button class="button" onclick="hideMore()">Peida</button></td>
    </tr>
    <script>
        var displayLimit = <?php echo $displayLimit; ?>;
        var resultRows = document.getElementsByClassName('resultRow');
        var showMoreRow = document.getElementById('showMoreRow');
        var hideMoreRow = document.getElementById('hideMoreRow');

        function showMore() {
            for (var i = displayLimit; i < resultRows.length; i++) {
                resultRows[i].style.display = 'table-row';
            }
            showMoreRow.style.display = 'none';
            hideMoreRow.style.display = 'table-row';
        }

        function hideMore() {
            for (var i = displayLimit; i < resultRows.length; i++) {
                resultRows[i].style.display = 'none';
            }
            showMoreRow.style.display = 'table-row';
            hideMoreRow.style.display = 'none';
        }
    </script>
    <?php
    } 
    } else {
    ?>
    <tr>
        <td colspan="5">Algavad kursused puuduvad</td>
    </tr>
    <?php
    }
    ?>
    </table>
    </table>
</div>
<!-- LÕPPENUD KURSUSED -->
<div class="grid-item">
    <table id="table4">
<h2>LÕPPENUD KURSUSED</h2>
<table>
    <tr class="table_row">
        <th scope="col" class="text_data box_width">Linastuse kood</th>
        <th scope="col" class="text_data">Kursuse nimetus</th>
        <th scope="col" class="number_data number_data_exception">Lõppemise kuupäev</th>
        <th scope="col" class="number_data box_width">Osalejate arv</th>
        <th scope="col" class="number_data box_width_2">Saatmata tunnistused/ tõendid</th>
    </tr>
    
    <?php
    $stmt3 = mysqli_prepare($conn, "SELECT DISTINCT Kursus.Kursuse_kood
    FROM Kursus
    LEFT JOIN Opilane_kursus ON Kursus.ID = Opilane_kursus.Kursus_ID
    LEFT JOIN Opilane ON Opilane_kursus.Opilane_ID = Opilane.ID
    LEFT JOIN Toend_tunnistus ON Opilane.ID = Toend_tunnistus.Opilane_ID AND Kursus.ID = Toend_tunnistus.Kursus_ID
    WHERE (Kursus.Loppemise_aeg >= DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 8 DAY) AND Kursus.Loppemise_aeg <= CURRENT_TIMESTAMP)
    OR (Toend_tunnistus.Opilane_ID IS NULL AND Toend_tunnistus.Kursus_ID IS NULL
    AND Kursus.Loppemise_aeg >= DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 8 DAY))
    ORDER BY Loppemise_aeg, Nimetus;");
    mysqli_stmt_bind_result($stmt3, $kursuse_kood_from_db);
    $stmt3->execute();
    $result5 = $stmt3->get_result();
    $rows3 = $result5->fetch_all(MYSQLI_ASSOC);
    if (!empty($rows3)) {
        $rowCounter4 = 0;
        for ($z = 0; $z < count($rows3); $z++) {
            $kursuse_kood = $rows3[$z]['Kursuse_kood'];
            $displayLimit4 = 5;
            $stmt4 = mysqli_prepare($conn, "SELECT 
            COUNT(DISTINCT Opilane_kursus.Opilane_ID) AS Osalevad_opilased, 
            COUNT(DISTINCT Toend_tunnistus.Opilane_ID) AS Koostatud_toendid_tunnistused,
            (COUNT(DISTINCT Opilane_kursus.ID) - COUNT(DISTINCT Toend_tunnistus.ID)) AS Saatmata_tunnistused,
            Kursus.Nimetus, 
            Kursus.Kursuse_kood, 
            DATE_FORMAT(Kursus.Loppemise_aeg, '%d.%m.%Y') AS FormattedDate,  
            Kursus.MAX_osalejad 
            FROM Kursus 
            LEFT JOIN Opilane_kursus ON Kursus.ID = Opilane_kursus.Kursus_ID 
            LEFT JOIN Opilane ON Opilane_kursus.Opilane_ID = Opilane.ID 
            LEFT JOIN Toend_tunnistus ON Opilane.ID = Toend_tunnistus.Opilane_ID 
            AND Kursus.ID = Toend_tunnistus.Kursus_ID 
            WHERE Kursus.Kursuse_kood = ? 
            GROUP BY Kursus.ID, Kursus.Nimetus, Kursus.Kursuse_kood, Kursus.Loppemise_aeg, Kursus.MAX_osalejad
            ORDER BY Kursus.Loppemise_aeg, Kursus.Nimetus");
            mysqli_stmt_bind_param($stmt4, "s", $kursuse_kood);
            $stmt4->execute();
            $result6 = $stmt4->get_result();
            $rows4 = $result6->fetch_all(MYSQLI_ASSOC);
            $osalevad2 = $rows4[0];
    ?>


        <tr class="resultRow4" <?php if ($z >= $displayLimit4) { echo 'style="display: none;"'; } ?>>
            <td class="text_data box_width"><?php echo $osalevad2['Kursuse_kood']; ?></td>
            <td class="text_data"><a href="Kursus/<?php echo $osalevad2['Kursuse_kood']; ?>.php" ><?php echo $osalevad2['Nimetus']; ?></a></td>
            <td class="number_data date"><?php echo $osalevad2['FormattedDate']; ?></td>
            <td class="number_data number_data_exception box_width"><?php echo $osalevad2['Osalevad_opilased']; ?>/<?php echo $osalevad2['MAX_osalejad']; ?></td>
            <td class="number_data number_data_exception box_width_2"><?php echo $osalevad2['Saatmata_tunnistused']; ?></td>
        </tr>
    <?php
        $rowCounter4++;
        }
        if (mysqli_num_rows($result5) > $displayLimit4) {
    ?>
        <tr id="showMoreRow4">
            <td colspan="5" style="text-align: center;">
            <button class="button" onclick="showMore4()">Vaata veel</button>
            </td>
        </tr>
        <tr id="hideMoreRow4" style="display: none;">
            <td colspan="5" style="text-align: center;">
            <button class="button" onclick="hideMore4()">Peida</button>
            </td>
        </tr>
    <?php
        } else {
    ?>
        <tr id="hideMoreRow4" style="display: none;">
            <td colspan="5" style="text-align: center;">
            <button class="button" onclick="hideMore4()">Peida</button>
            </td>
        </tr>
    <?php
        }
    } else {
    ?>
        <tr>
        <td colspan="5">Lõppenud kursused puuduvad</td>
        </tr>
    <?php
    }
    ?>
    </table>
</div>
<script>
    var rowCounter4 = 0;
    var displayLimit4 = <?php echo $displayLimit4; ?>;
    var resultRows4 = document.getElementsByClassName('resultRow4');
    var showMoreRow4 = document.getElementById('showMoreRow4');
    var hideMoreRow4 = document.getElementById('hideMoreRow4');

    function showMore4() {

    for (var i = displayLimit4; i < resultRows4.length; i++) {
        resultRows4[i].style.display = 'table-row';
    }

    showMoreRow4.style.display = 'none';
    hideMoreRow4.style.display = 'table-row';
    }

    function hideMore4() {

    for (var i = displayLimit4; i < resultRows4.length; i++) {
        resultRows4[i].style.display = 'none';
    }

    showMoreRow4.style.display = 'table-row';
    hideMoreRow4.style.display = 'none';
    }
</script>
</div>
</div>
</body>
</html>

