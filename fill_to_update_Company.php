<!DOCTYPE html>
<html>
<head>
	<title>Update Company</title>
	<style>
        body{
          text-align: center;
        }

        #form-wrapper{
          margin-left: 25%;
          margin-right: 25%;
          background: #F6D29D;

        }

        form{
          text-align: left;
          padding-left: 0.5em;
        }

        input{
          margin: 0.5em;
        }

        a {
          margin: 0.5em; }
        }
        a:hover {
          color: #093a58;

        }
        #buttons {
          text-align: center;
          margin-top: 1em;
          
        }

        button{
          margin-bottom: 0.5em;
        }


      </style>
</head>
<body>
	<h1>Update Company Information</h1>

	<div id=form-wrapper>

	<form action="update_Company.php" method="post"> 
	<?php 
	include_once 'db.php'; 

	$company_ID =$_POST['company_ID']; 

	# prepared statement with Unnamed Placeholders 
	$query = "select * from Company where company_ID = ?;"; 
	$stmt = $conn->prepare($query); 
	$stmt->bindValue(1, $company_ID); # bind by value and assign variables to each place holder
	$stmt->execute(); 
	$stmt->setFetchMode(PDO::FETCH_NUM); 
	$row = $stmt->fetch(); 

	printf("<input type=\"hidden\" name=\"company_ID\" value=\"%s\"/><br>\n",$row[0]); 
	printf("Company_name: <input type=\"text\" name=\"name\" value=\"%s\"/><br>\n",$row[1]); 
	printf("Phone_number: <input type=\"text\" name=\"phone_number\" value=\"%s\"/><br>",$row[2]); 
	printf("Street_number: <input type=\"text\" name=\"street_number\" value=\"%s\"/><br>",$row[3]);
	printf("Street_name: <input type=\"text\" name=\"street_name\" value=\"%s\"/><br>",$row[4]); 
	printf("City: <input type=\"text\" name=\"city\" value=\"%s\"/><br>",$row[5]); 
	printf("State: <input type=\"text\" name=\"State\" value=\"%s\"/><br>",$row[6]); 
	printf("Zip_code: <input type=\"text\" name=\"Zip_code\" value=\"%s\"/><br>",$row[7]);     
	?> 
	<br/> 
	<div id=buttons>
	<input type="Submit" value= "Update"/><input type="Reset"/> 
	</div>
	</form>
	<a href="index.html"><button>Home Page</button></a>
	</div>

</body>
</html>


