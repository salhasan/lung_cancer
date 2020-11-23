<!DOCTYPE html>
<html>
<head>
	<title>Insert a New Patient</title>
	<link rel="stylesheet" href="main.css">
	<style>
		tbody {
	    display:block;
	    height:200px;
	    overflow:auto;
	}
		thead, tbody tr {
	    display:table;
	    width:100%;
	    table-layout:fixed;
	}
	</style>


</head>
<body>
	<header>
      <h1>Lung Cancer Clinical Trials</h1>
    </header>

<div id="table-wrap">

<?php
//form data
$p_ID=$_POST['p_ID'];
$age=$_POST['age'];
$sex=$_POST['sex'];
$race=$_POST['race'];
$start_date=$_POST['start_date'];
$CT_ID=$_POST['CT_ID'];

//connection DSN

include_once 'db.php';

try {
	$conn = new PDO("mysql:host=$host;dbname=$dbname", $user, $pass);
	$conn->setAttribute( PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );

	#use prepared statment with named placeholders
	$sql = "insert into Patients (patient_ID, age, sex, race, start_date, CT_ID)
	values(:p_ID, :age, :sex, :race, :start_date, :CT_ID)";
	$stmt = $conn->prepare($sql);

	$stmt->bindParam(':p_ID', $p_ID);
	$stmt->bindParam(':age', $age);
	$stmt->bindParam(':sex', $sex);
	$stmt->bindParam(':race', $race, PDO::PARAM_INT);
	$stmt->bindParam(':start_date', $start_date);
	$stmt->bindParam(':CT_ID', $CT_ID);

	if($stmt->execute()){
		$rows_affected = $stmt->rowCount();
		echo "<h2>".$rows_affected." row added sucessfully!</h2>";
		echo "<a href='index.html'><button>Home Page</button></a><br>";


		$stmt = $conn->query("SELECT * FROM Patients");

		//PDO::FETCH_NUM: returns an array indexed by column number as returned in your result set, starting at column 0
		$stmt->setFetchMode(PDO::FETCH_NUM);

		echo "<table id='td' border=\"1\">\n";
		echo "<tr><th>Patient ID</th><th>Age</th><th>Sex</th><th>Race</th><th>Start Date</th><th>Clinical Trial ID</th></tr>\n";
		
		while ($row = $stmt->fetch()) {
			printf("<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>\n", $row[0], $row[1], $row[2], $row[3], $row[4], $row[5]);
		}
		$result->close();
		echo "</table>\n";

		
	}
	else
	{
		echo "Insertion failed: (" . $conn->errno . ") " . $conn->error;
	}



	$conn = null;
}
catch(PDOException $e) {
	die("Could not connect to the database $dbname :" . $e->getMessage());
}
	

?>
</div>



</body>
</html>