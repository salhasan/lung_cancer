<!DOCTYPE html>
<html>
<head>
	<title>Select a Company to Update</title>
	<link rel="stylesheet" href="main.css">
	<style>
		table{
		  margin-left: 15%;
		  margin-right: 15%;
		  margin-bottom: 5%;
		  font-family: 'Saira', sans-serif;
		  line-height: 1.6;
		  color: #3a3a3a;
		}

		#form-wrapper{
			background: #F6D29D;
			margin-left: 15%;
		  	margin-right: 15%;
		 	margin-bottom: 0.5em;
    		padding-bottom: 0.5em;
		}

		a {

    	margin-top: 0.5em;
		}	

		td{
    	word-wrap:break-word
		}

		input{
          margin-top: 0.5em;
        }
        button {
    	margin-top: 0.5em;
    	margin-bottom: 0.5em;
		}
	</style>

</head>
<body>
	<header>
      <h1>Lung Cancer Clinical Trials</h1>
    </header>

<div id="form-wrapper">
<form action="fill_to_update_Company.php" method="post"> 
<h2>Type in the Company_ID to Update: </h2> 
Company_ID: <input type="text" placeholder="Comp_XX" name="company_ID"/><br> 
<input type="Submit" value= "Select"/><input type="Reset"/> 
</form>


</div>

<a href='index.html'><button>Home Page</button></a>

	<?php 
 include_once 'db.php'; 
 include 'display.php'; 

 display("SELECT * FROM Company;"); 

 
?> 

<br/> 





</body>
</html>

