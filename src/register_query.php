<!DOCTYPE HTML>
<html>
<head>
<title>Register Result</title>
<link href="style.css" rel="stylesheet" type="text/css" />
</head>

<h1>Register Result</h1>

<?php
    $email = $_POST['email'];
    $fname = $_POST["fname"];
    $mname = $_POST["mname"];
    $sname = $_POST["sname"];
    $dob = $_POST["dob"];
    $hphone = $_POST["hphone"];
    $mphone = $_POST["mphone"];
    $wphone = $_POST["wphone"];

    require_once "connection.php";
    $mysqli = new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);

    
	if ($mysqli->connect_errno) {
		
		echo "Sorry, this website is experiencing problems.";

		
		echo "Error: Failed to make a MySQL connection, here is why: \n";
		echo "Errno: " . $mysqli->connect_errno . "\n";
		echo "Error: " . $mysqli->connect_error . "\n";
		
		exit;
	}

    

    

    if($mname == ""){
        // for people without middle name
        if (!($stmt = $mysqli->prepare("INSERT INTO player(email,forename,surname,date_of_birth) VALUES(?,?,?,?)"))) {
		    echo "Prepare failed: (" . $mysqli->errno . ") " . $mysqli->error;
	    }

        // Prepared statement: bind and execute
	    if (!$stmt->bind_param("ssss", $email, $fname, $sname, $dob)) {
		    echo "Binding parameters failed: (" . $stmt->errno . ") " . $stmt->error;
        }
    }else{
        // Prepared statement
	if (!($stmt = $mysqli->prepare("INSERT INTO player(email,forename,middlenames,surname,date_of_birth) VALUES(?,?,?,?,?)"))) {
		echo "Prepare failed: (" . $mysqli->errno . ") " . $mysqli->error;
	}

    // Prepared statement: bind and execute
    if (!$stmt->bind_param("sssss", $email, $fname, $mname,$sname, $dob)) {
        echo "Binding parameters failed: (" . $stmt->errno . ") " . $stmt->error;
    }
    }
    // Perform an SQL query
	if (!$stmt -> execute()) {
		echo "Sorry, the website is experiencing problems.";

		echo "Error: Our query failed to execute and here is why: \n";
		echo "Query: " . $sql . "\n";
		echo "Errno: " . $mysqli->errno . "\n";
		echo "Error: " . $mysqli->error . "\n";
		exit;
	}
    // for possible phone option
    if (!($stmt = $mysqli->prepare("INSERT INTO player_phone VALUES(?,?,?)"))) {
		echo "Prepare failed: (" . $mysqli->errno . ") " . $mysqli->error;
	}
    $ptype = "";
    if($hphone != ""){
        $ptype  = "home";
        if (!$stmt->bind_param("sss", $email, $hphone, $ptype)) {
		    echo "Binding parameters failed: (" . $stmt->errno . ") " . $stmt->error;
        }
        if (!$stmt -> execute()) {
            echo "Sorry, the website is experiencing problems.";
    
            echo "Error: Our query failed to execute and here is why: \n";
            echo "Query: " . $sql . "\n";
            echo "Errno: " . $mysqli->errno . "\n";
            echo "Error: " . $mysqli->error . "\n";
            exit;
        }
    }

    if($wphone != ""){

        $ptype  = "work";
        if (!$stmt->bind_param("sss", $email, $wphone, $ptype)) {
		    echo "Binding parameters failed: (" . $stmt->errno . ") " . $stmt->error;
        }
        if (!$stmt -> execute()) {
            echo "Sorry, the website is experiencing problems.";
    
            echo "Error: Our query failed to execute and here is why: \n";
            echo "Query: " . $sql . "\n";
            echo "Errno: " . $mysqli->errno . "\n";
            echo "Error: " . $mysqli->error . "\n";
            exit;
        }
    }

    if($mphone != ""){
        $ptype  = "mobile";
        if (!$stmt->bind_param("sss", $email, $mphone, $ptype)) {
		    echo "Binding parameters failed: (" . $stmt->errno . ") " . $stmt->error;
        }
        if (!$stmt -> execute()) {
            echo "Sorry, the website is experiencing problems.";
    
            echo "Error: Our query failed to execute and here is why: \n";
            echo "Query: " . $sql . "\n";
            echo "Errno: " . $mysqli->errno . "\n";
            echo "Error: " . $mysqli->error . "\n";
            exit;
        }
    }

    echo "Query Executed";


?>

<p><a href="index.html"><h2>Go back to Home</h2></a>
</body>
</html>