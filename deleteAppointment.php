<?php
// database connection vars
$servername = "localhost";
$db_username = "root";
$db_password = "root";
$dbname = "310-project";

// Create connection
$con = new mysqli($servername, $db_username, $db_password, $dbname);

// Check connection
if ($con->connect_error) {
    die("Connection failed: " . $con->connect_error);
}

$apt_id = $_POST['apt_del'];

$del_comment = "DELETE FROM comment WHERE apt_id = $apt_id";
$del_review = "DELETE FROM review WHERE apt_id = $apt_id";
if(mysqli_query($con, $del_comment) && mysqli_query($con, $del_review))
{
    $del_appointment="DELETE FROM appointment WHERE apt_id = $apt_id";
    if(mysqli_query($con, $del_appointment))
    {
        Print '<script>alert("Appointment deleted!");</script>';     
        Print '<script>window.location.assign("userhome.php");</script>';
    }
    else
    {
        Print '<script>alert("Appointment not deleted");</script>';     
        Print '<script>window.location.assign("userhome.php");</script>';
    }
}
else
{
    Print '<script>alert("Appointment not deleted");</script>';     
    Print '<script>window.location.assign("userhome.php");</script>';
}
?>