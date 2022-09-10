<!DOCTYPE HTML>
<html>
<head>
<title>Result</title>
<link href="style.css" rel="stylesheet" type="text/css" /> 
</head>

<h1>Fetch result</h1>
<?php

    if(isset($_POST['venue'])){
        $varvenue = $_POST['venue'];
        var_export($varvenue);
    }else{
        echo "Error: post is empty!";
        exit;
    }
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
	if (!($stmt = $mysqli->prepare("SELECT match_venue.id AS match_id ,GROUP_CONCAT(name) AS names , match_venue.date_played AS date_played from (((SELECT * FROM played_match WHERE venue_name = ?) AS match_venue) LEFT JOIN (( SELECT email, CONCAT_WS(\" \",forename,middlenames,surname) AS name FROM player) AS player_name) ON player_name.email = match_venue.p1_email OR player_name.email = match_venue.p2_email) GROUP BY match_venue.id"))) {
		echo "Prepare failed: (" . $mysqli->errno . ") " . $mysqli->error;
	}

    // Prepared statement: bind and execute
    
	if (!$stmt->bind_param("s", $varvenue)) {
		echo "Binding parameters failed: (" . $stmt->errno . ") " . $stmt->error;
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
		
		echo "We could not find a match for venue '$varvenue', sorry about that. Please try again.";
	}
	else {
		echo "<table>\n";
		echo "<tr><th>Match ID</th><th>Match Date</th><th>Players</th></tr>\n"; //table header row

		// Print our results in a table
		while ($game = $result->fetch_assoc()) {
			echo "<tr><td>" . $game['match_id'] . "</td><td>" . $game['date_played'] . "</td><td>" . $game['names'] . "</td></tr>\n";
		}
		echo "</table>\n";
	}
	
	$result->free();
	$mysqli->close();
?>

<p><a href="index.html"><h2>Go back to Home</h2></a>
</body>
</html>