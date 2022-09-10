<!DOCTYPE HTML>
<html>
<head>
<title>Fetch venue</title>
<link href="style.css" rel="stylesheet" type="text/css" />  
</head>

<h1>Fetch venue</h1>
<?php
    require_once "connection.php";
    $mysqli = new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);

    
	if ($mysqli->connect_errno) {
		echo "Sorry, this website is experiencing problems.";
		echo "Error: Failed to make a MySQL connection, here is why: \n";
		echo "Errno: " . $mysqli->connect_errno . "\n";
		echo "Error: " . $mysqli->connect_error . "\n";
		
		// You might want to show them something nice, but we will simply exit
		exit;
	}

    // Prepared statement
	if (!($stmt = $mysqli->prepare("SELECT name FROM venue"))) {
		echo "Prepare failed: (" . $mysqli->errno . ") " . $mysqli->error;
	}

    // Perform an SQL query
	if (!$stmt -> execute()) {
		// Oh no! The query failed. 
		echo "Sorry, the website is experiencing problems.";

		// Again, do not do this on a public site, but we'll show you how
		// to get the error information
		echo "Error: Our query failed to execute and here is why: \n";
		echo "Query: " . $sql . "\n";
		echo "Errno: " . $mysqli->errno . "\n";
		echo "Error: " . $mysqli->error . "\n";
		exit;
	}

	$result = $stmt->get_result();
	if ($result -> num_rows === 0) {
		echo "We could not find a match for name '$name', sorry about that. Please try again.";
	}
	else {
		$venue = $result->fetch_all();
	}
?>
<br>
<form action = "result_venue.php" method = "post">
	<label for = "venue"> Select a venue:</label>
	<select name = "venue">
		<?php
		foreach($venue as $key => $value):
			echo '<option value = "'.$value[0].'">'.$value[0].'</option>';
		endforeach;
		?>
	</select>
	<br>
	<input type = "submit" value = "Select">
</form>
    <p><a href="index.html"><h2>Go back to Home</h2></a>
</html>