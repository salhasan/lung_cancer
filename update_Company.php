<!DOCTYPE html>
<html>
<head>
	<title>Updated Company Information</title>
	<link rel="stylesheet" href="main.css">


</head>
<body>

	<header>
      <h1>Lung Cancer Clinical Trials</h1>
    </header>



	<div id="table-wrap">

		<?php 

			include_once 'db.php'; 

			# form data 
			$Company_ID = $_POST['company_ID']; 
			$Company_name=$_POST['name']; 
			$Phone_number=$_POST['phone_number']; 
			$Street_number=$_POST['street_number']; 
			$Street_name=$_POST['street_name']; 
			$City=$_POST['city']; 
			$State=$_POST['State']; 
			$Zip_code=$_POST['Zip_code']; 

			$query = "update Company set name = :name, phone_number = :phone_number, street_number = :street_number, street_name = :street_name, city = :city, State = :State, Zip_code = :Zip_code where company_ID = :company_ID;"; 
			$data = array( 'name' => $Company_name, 'phone_number' => $Phone_number , 'street_number' => $Street_number, 'street_name' => $Street_name, 'city' => $City, 'State' => $State, 'Zip_code' => $Zip_code, 'company_ID' => $Company_ID); 
			$stmt = $conn -> prepare($query); 

			if($stmt -> execute($data)) 
			{ 
				$rows_affected = $stmt->rowCount(); 
				echo "<h2>".$rows_affected." row updated sucessfully!</h2>";
				echo "<a href='index.html'><button>Home Page</button></a>";
				include 'display.php'; 
				display("SELECT * FROM Company;"); 
			}
			else 
			{ 
				echo "update failed: (" . $conn->errno . ") " . $conn->error; 
			}
			$conn->close(); 
		?>
	</div>



</body>
</html>


