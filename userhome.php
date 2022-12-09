<html>
    <head>
        <title>Homepage</title>
        <link rel = "stylesheet" href = "style.css">
        <!-- <link rel= "icon" type = "image" href = "img/tooth.png"> -->
        <link rel="icon" type="image/x-icon" href="img/favicon.ico">
    </head>
    <body style="background-color:rgb(232, 231, 220);">

    <div class = "topnav">
    <a style="font-family: Arial, Helvetica, sans-serif; font-weight:bold">Aggie Dentistry</a>
    <a style="font-family: Arial, Helvetica, sans-serif; font-weight:bold" href = "userhome.php"> Home </a>
    <a style="font-family: Arial, Helvetica, sans-serif; font-weight:bold" href = "profile.php"> Profile </a>

    <div class="topnav-right">
    <a style="font-family: Arial, Helvetica, sans-serif; font-weight:bold" href = "logout.php"> Logout </a>
    </div>
    </div>
	    
    <?php
    session_start(); //starts the session
    if($_SESSION['user']){ // checks if the user is logged in  
    }
    else{
        header("location: index.php"); // redirects if user is not logged in
    }
    $user = $_SESSION['user']; //assigns user value
    $isAdmin = $_SESSION['admin'];
    $userid = $_SESSION['userid'];
    ?>
    <body>
    <div style = "text-align:center;">
        <p style = "text-align:center; font-family: Arial, Helvetica, sans-serif;">Howdy <?php Print "$user"?>!</p> <!--Displays user's name-->
        <!-- <a href="logout.php">Click here to go logout</a> -->
        
        <a href="scheduleApp.php">Click here to schedule an appointment</a>
        <h2 style="align: center">Available Services</h2>
        <a href="service.php">See Offered Services</a>
    	<h2 style="align: center">Appointments</h2>
        </div>

        <?php if($isAdmin == 1) : ?>
            <table style="border: 1px" width="100%">
            <tr>
                <th>Appointment Number</th>
                <th>Appointment Date</th>
                <th>Appointment Time</th>
                <th>Doctor</th>
                <th>Service</th>
                <th>Price</th>
                <th>Comments</th>
                <th>Review</th>
                <th>Delete?</th>
            </tr>   
        <?php
            error_reporting(E_ERROR | E_PARSE);
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

            $user_id = $_SESSION['userid'];

            // $query = "SELECT * FROM appointment";
            $query = "SELECT * FROM appointment WHERE admin_id='$user_id'";
            $result = mysqli_query($con, $query); // Select rows with same username
            $exists = mysqli_num_rows($result); // count the number of rows, if greater than zero then username exists
            $appIds = array();
            // //printf("Result set has %d rows.\n",$exists);
            if($exists > 0) //IF there are no returning rows or no existing username
            {
                $count = 1;
                while ($row = mysqli_fetch_array($result)) {
                    // add the appId to array
                    $appIds[$count - 1] = $row[0];
                    // get doctor info
                    $getDoctorName = "SELECT user_fname, user_lname FROM profile WHERE profile_id = $row[7]";
                    $docresult = mysqli_query($con, $getDoctorName); // Select rows with same username
                    $doctor = mysqli_fetch_array($docresult);
                    // get service info
                    $getServiceName = "SELECT service_name FROM service WHERE service_id = $row[5]";
                    $serviceresult = mysqli_query($con, $getServiceName); // Select rows with same username
                    $service = mysqli_fetch_array($serviceresult);
                    // get comment info
                    if(!is_null($row[8])) {
                        $getComment = "SELECT comment_value FROM comment WHERE comment_id = $row[8]";
                        $commentresult = mysqli_query($con, $getComment); // Select rows with same username
                        $comment = mysqli_fetch_array($commentresult);
                    } else {
                        $getComment = "SELECT comment_value FROM comment WHERE comment_id = NULL";
                        $commentresult = mysqli_query($con, $getComment); // Select rows with same username
                        $comment = mysqli_fetch_array($commentresult);
                    }
                    // get review info
                    if(!is_null($row[9])) {
                        $getReview = "SELECT review_value FROM review WHERE review_id = $row[9]";
                        $reviewResult = mysqli_query($con, $getReview); // Select rows with same username
                        $review = mysqli_fetch_array($reviewResult);
                    } else {
                        $getReview = "SELECT review_value FROM review WHERE review_id = NULL";
                        $reviewResult = mysqli_query($con, $getReview); // Select rows with same username
                        $review = mysqli_fetch_array($reviewResult);
                    }
                    echo "<tr>
                            <th>$count</th>
                            <th>$row[1]</th>
                            <th>$row[2]</th>
                            <th>$doctor[0] $doctor[1]</th>
                            <th>$service[0]</th>
                            <th>$$row[4]</th>
                            <th><form action='userhome.php' method='POST'>
                                <textarea id='comment' name='comment$row[0]' cols='40' rows='5'>$comment[0]</textarea>
                                <input type='submit' value='Submit'/>
                            </form></th>
                            <th><p id='review' name='review$row[0]'>$review[0]</p></th>
                            <th><form action='deleteAppointment.php' method='post'><input type='hidden' name='apt_del'
                                value=$row[0]><input type='submit' value='DELETE'>
                            </form></th>
                        </tr>";
                    $count += 1;
                }
            }

        ?>
		</table>
        <?php elseif($isAdmin == 0) : ?> 
            <table style="border: 1px" width="100%">
            <tr>
                <th>Appointment Number</th>
                <th>Appointment Date</th>
                <th>Appointment Time</th>
                <th>Doctor</th>
                <th>Service</th>
                <th>Price</th>
                <th>Review</th>
            </tr>   
        <?php
            error_reporting(E_ERROR | E_PARSE);
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

            $query = "SELECT * FROM appointment WHERE user_id = (SELECT profile_id FROM profile WHERE username = '$user' AND profile_id = $userid)";
            $result = mysqli_query($con, $query); // Select rows with same username
            $exists = mysqli_num_rows($result); // count the number of rows, if greater than zero then username exists
            $appIds = array();
            // //printf("Result set has %d rows.\n",$exists);
            if($exists > 0) //IF there are no returning rows or no existing username
            {
                $count = 1;
                while ($row = mysqli_fetch_array($result)) {
                    // add the appId to array
                    $appIds[$count - 1] = $row[0];
                    // get doctor info
                    $getDoctorName = "SELECT user_fname, user_lname FROM profile WHERE profile_id = $row[7]";
                    $docresult = mysqli_query($con, $getDoctorName); // Select rows with same username
                    $doctor = mysqli_fetch_array($docresult);
                    $doctors[$count - 1] = $doctor;
                    // get service info
                    $getServiceName = "SELECT service_name FROM service WHERE service_id = $row[5]";
                    $serviceresult = mysqli_query($con, $getServiceName); // Select rows with same username
                    $service = mysqli_fetch_array($serviceresult);
                    // get review info
                    echo $row[9];
                    if(!is_null($row[9])) {
                        $getReview = "SELECT review_value FROM review WHERE review_id = $row[9]";
                        $reviewResult = mysqli_query($con, $getReview); // Select rows with same username
                        $review = mysqli_fetch_array($reviewResult);
                    } else {
                        $getReview = "SELECT review_value FROM review WHERE review_id = NULL";
                        $reviewResult = mysqli_query($con, $getReview); // Select rows with same username
                        $review = mysqli_fetch_array($reviewResult);
                    }
                    echo "<tr>
                            <th>$count</th>
                            <th>$row[1]</th>
                            <th>$row[2]</th>
                            <th>$doctor[0] $doctor[1]</th>
                            <th>$service[0]</th>
                            <th>$row[4]</th>
                            <th><form action='userhome.php' method='POST'>
                                <textarea id='review' name='review$row[0]' cols='40' rows='5'>$review[0]</textarea>
                                <input type='submit' value='Submit'/>
                            </form></th>
                        </tr>";
                    $count += 1;
                }
            }

        ?>
		</table>
        <?php endif; ?>

        
	</body>
</html>

<?php
if($_POST) {
    $date = date('Y-m-d H:i:s');
    for ($x = 0; $x < $exists; $x++) {
        // $doctorFirstName = $doctors[$x][0];
        // $doctorLastName = $doctors[$x][1];
        $comment = $_POST["comment$appIds[$x]"];
        $review = $_POST["review$appIds[$x]"];
        // Print '<script>alert("made it here!");</script>';

        if (isset($_POST["comment$appIds[$x]"])) {
            // Print '<script>alert("made it to comment!");</script>';
            $sql = "INSERT INTO comment (comment_id, comment_date, comment_value, user_id, admin_id, apt_id) VALUES (0, '$date', '$comment', (SELECT user_id FROM appointment WHERE apt_id = $appIds[$x]), (SELECT admin_id FROM appointment WHERE apt_id = $appIds[$x]), $appIds[$x])";
            if($con->query($sql) === TRUE) {
                $sql = "UPDATE appointment SET comment_id = $con->insert_id WHERE apt_id = $appIds[$x]";
                if($con->query($sql) === TRUE) {
                    Print '<script>alert("Successfully added comment!");</script>';     
                    Print '<script>window.location.assign("userhome.php");</script>';
                } else {
                    Print '<script>alert("Comment not added!");</script>';     
                    Print '<script>window.location.assign("userhome.php");</script>';
                }
            } else {
                Print '<script>alert("Comment not added!");</script>';     
                Print '<script>window.location.assign("userhome.php");</script>';
            }
        } elseif (isset($_POST["review$appIds[$x]"])) {
            // Print '<script>alert("made it to review!");</script>';
            $sql = "INSERT INTO review (review_id, review_date, review_value, user_id, admin_id, apt_id) VALUES (0, '$date', '$review', (SELECT user_id FROM appointment WHERE apt_id = $appIds[$x]), (SELECT admin_id FROM appointment WHERE apt_id = $appIds[$x]), $appIds[$x])";
            if ($con->query($sql) === TRUE) {
                $sql = "UPDATE appointment SET review_id = $con->insert_id WHERE apt_id = $appIds[$x]";
                if ($con->query($sql) === TRUE) {
                    Print '<script>alert("Successfully added review");</script>';
                    Print '<script>window.location.assign("userhome.php");</script>';
                } else {
                    Print '<script>alert("Error adding review");</script>';
                    Print '<script>window.location.assign("userhome.php");</script>';
                }

            } else {
                Print '<script>alert("Error adding review");</script>';
                Print '<script>window.location.assign("userhome.php");</script>';
            }
        } else {
            // do nothing, no comment or review added
            // Print '<script>alert("Nothing happened");</script>';
        }
        
    }
}
?>
