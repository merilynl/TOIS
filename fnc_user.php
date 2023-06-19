<?php
	require_once "../../config_tarkvaraarendus2023.php";
	function sign_up($username, $password) {
		$notice = null;
		$conn = new mysqli($GLOBALS["server_host"], $GLOBALS["server_user_name"], $GLOBALS["server_password"], $GLOBALS["database"]);
		$conn->set_charset("utf8");
		echo $conn->error;
		$stmt = $conn->prepare("SELECT ID, Kasutajanimi FROM Kasutajakonto WHERE Kasutajanimi = ?");
		$stmt->bind_param("s", $username);
		$stmt->execute();
		if($stmt->fetch()){
			$notice = "Error, sisestatud kasutajanimega on juba seotud teine kasutaja";
			$stmt->close();
			$conn->close();
			return $notice;
		} else{
			$stmt = $conn->prepare("INSERT INTO Kasutajakonto (Kasutajanimi, Parool_hash) values(?,?)");
			$pwd_hash = password_hash($password, PASSWORD_DEFAULT);
			$stmt->bind_param("ss", $username, $pwd_hash);
							
			if($stmt->execute()){
				$notice = "Uus kasutaja on salvestatud.";
			} else {
				$notice = "error" .$stmt->error;
			}
			$stmt->close();
			$conn->close();
			return $notice;
		}
	}
	
	function sign_in($username, $password){
            if(isset($password) and !empty($password) and isset($username) and !empty($username)){
                    $conn = new mysqli($GLOBALS["server_host"], $GLOBALS["server_user_name"], $GLOBALS["server_password"], $GLOBALS["database"]);
                    $conn->set_charset("utf8");
                    echo $conn->error;
                    $stmt = $conn->prepare("SELECT Parool_hash FROM Kasutajakonto WHERE Kasutajanimi = ?");
                    $stmt->bind_param("s", $username);
                    $stmt->bind_result($password_from_db);
                    $stmt->execute();
                    if($stmt->fetch()){
                        if(password_verify($password, $password_from_db)){
							$stmt->close();
                            $conn->close();
                            header("Location: Toolaud.php");
							exit();  
                        }else{
						$login_error = "sisselogimise ebaõnnestus, kasutajatunnus või salasõna oli ebakorrektne!";
						$stmt->close();
						$conn->close();
						}
                    }else{
                      $login_error = "sisselogimise ebaõnnestus, kasutajatunnus või salasõna oli ebakorrektne!";
                      $stmt->close();
                      $conn->close();
                    }
            } else {
			$login_error = "sisselogimise ebaõnnestus, kasutajatunnus või salasõna oli sisestamata!";
            }
	return $login_error;
	}
	
?>