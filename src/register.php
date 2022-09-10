<!DOCTYPE HTML>
<html>
<head>
<title>Register</title>
<link href="style.css" rel="stylesheet" type="text/css" />  
<script>
    function validation(){
        let xemail = document.forms["registerForm"]["email"].value;
        let xfname = document.forms["registerForm"]["fname"].value;
        let xsname = document.forms["registerForm"]["sname"].value;
        let xdob = document.forms["registerForm"]["dob"].value;
        if (xemail == "") {
           alert("Email must be filled out");
           return false;
        }
        if(xfname == ""){
            alert("First Name must be filled out");
           return false;
        }
        if(xsname == ""){
            alert("Surname must be filled out");
           return false;
        }
        if(xdob == ""){
            alert("Date of Birth must be filled out");
           return false;
        }
    }
</script>
</head>
<h1>Register</h1>
<form name ="registerForm" action = "register_query.php" onsubmit = "return validation()" method = "post">
    <label for = "email">Email*:</label><br>
    <input type = "text" id = "email" name = "email"><br>
    <label for = "fname">First Name*:</label><br>
    <input type = "text" id = "fname" name = "fname"><br>
    <label for = "mname">Middle Name:</label><br>
    <input type = "text" id = "mname" name = "mname"><br>
    <label for = "sname">SurName*:</label><br>
    <input type = "text" id = "sname" name = "sname"><br>
    <label for = "dob">Date of Birth(in yyyymmdd or yyyy-mm-dd):</label><br>
    <input type = "text" id = "dob" name = "dob"><br>
    <label for = "hphone">Home Phone:</label><br>
    <input type = "text" id = "hphone" name = "hphone"><br>
    <label for = "mphone">Mobile Phone:</label><br>
    <input type = "text" id = "mphone" name = "mphone"><br>
    <label for = "wphone">Work Phone:</label><br>
    <input type = "text" id = "wphone" name = "wphone"><br>
    <input type = "submit" value = "register">
</form>

<p><a href="index.html"><h2>Go back to Home</h2></a>
</html>