<?php
	require_once "fnc_user.php";
	
	$notice = null;
    $username_error = null;
    $password_error = null;
    $username = null;
    $password = null;

	if($_SERVER["REQUEST_METHOD"] == "POST"){
		if (isset($_POST["user_data_submit"])){
			
			if(isset($_POST["username_input"]) and !empty($_POST["username_input"])){
				$username = $_POST["username_input"];
			} else {
				$username_error = "Palun sisestage kasutajatunnus!";
			}
			if(isset($_POST["password_input"]) and !empty($_POST["password_input"])){
				$password = $_POST["password_input"];
			} else {
				$password_error = "Palun sisesta parool!";
			}
            if(empty($username_error) and empty($password_error)){
				
				$notice = sign_in($username, $password);
				if (empty($notice)){
					echo ("login sisse");
				}
			}
		}
	}		
?>

<!DOCTYPE html>
<html lang="et">
  <head>
    <meta charset="utf-8">
	
  </head>
  <body>
	
	<hr>
    <h2>Logi sisse</h2>
    <p><a href=""></a></p>
		
	<form method="POST" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>"> 
	  <br>
	  <label for="username_input">Kasutajatunnus:</label><br>
	  <input name="username_input" id="username_input" value=" <?php echo $username; ?>"><span><?php echo $username_error; ?></span><br>
      <br>
	  <label for="password_input">Salasõna:</label><br>
	  <input name="password_input" id="password_input" type="password"><span><?php echo $password_error; ?></span><br>
      <br>
	  <input name="user_data_submit" type="submit" value="Login" ><span><?php echo $notice; ?></span>
	</form>
	<hr>
    
  </body>
</html>