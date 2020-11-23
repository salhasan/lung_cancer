<!DOCTYPE html>
<html>
  <head>
    <title>Companies</title>
    <link rel="stylesheet" href="main.css">
   

  </head>
  <body>
     <header>
      <h1>Lung Cancer Clinical Trials</h1>
    </header>
    <p>The table below shows informations about companies that develope drugs for adenocarcinoma</p>

    <div id="table-wrap">

    <?php

    include_once 'db.php';

    //execute the query
    $stmt = $conn->query('select distinct Company.name as Company_Name , Company.phone_number as Company_Phone_Number, Company.Zip_code as Company_Zip_Code from Company left join Developed on Company.company_ID = Developed.company_ID left join Drug_Procedure on Developed.DP_ID = Drug_Procedure.DP_ID left join Used_In on Drug_Procedure.DP_ID = Used_In.DP_ID left join Clinical_Trials on Used_In.CT_ID = Clinical_Trials.CT_ID where Clinical_Trials.description="Adenocarcinoma";');
    //set the fetch mode to associate array
    $stmt->setFetchMode(PDO::FETCH_ASSOC);
    // create result table headers
      echo "<table id='td' border=1>\n";
      echo "<tr><th>Company_Name</th><th>Company_Phone_Number</th><th>Company_Zip_Code</th></tr>\n";
      // print all rows using a loop
    while ($row = $stmt->fetch()) {
      printf("<tr><td>%s</td><td>%s</td><td>%s</td></tr>\n", $row['Company_Name'], $row['Company_Phone_Number'],$row['Company_Zip_Code'] );
    }
    echo "</table>\n";

    //disconnect from the database
    $stmt = null;
    $conn = null;
   
    ?>

   </div>
     <a href="index.html"><button>Home Page</button></a>
  </body>
</html>