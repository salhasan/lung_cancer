<!DOCTYPE html>
<html>
  <head>
    <title>Patient Per Drug</title>
    <link rel="stylesheet" href="main.css">
  </head>
  <body>

    <header>
      <h1>Lung Cancer Clinical Trials</h1>
    </header>

    <p>The table below shows the number of patients using a drug by sex</p>
    <div id="table-wrap">
    <?php
    include_once 'db.php'; 
    //execute the query
    $stmt = $conn->query('select name as Drug_Name,count(Patients.patient_ID) as Number_Of_Patients,Patients.sex as Patient_Sex from Drug_Procedure left join Used_In on Drug_Procedure.DP_ID = Used_In.DP_ID left join Patients on Used_In.CT_ID = Patients.CT_ID where Used_In.CT_ID IS NOT NULL group by name,Patients.sex;');
    //set the fetch mode to associate array
    $stmt->setFetchMode(PDO::FETCH_ASSOC);
    // create result table headers
      echo "<table id='td' border=1>\n";
      echo "<tr><th>Drug_Name</th><th>Number_of_Patients</th><th>Patient_Sex</th></tr>\n";
      // print all rows using a loop
    while ($row = $stmt->fetch()) {
      printf("<tr><td>%s</td><td>%s</td><td>%s</td></tr>\n", $row['Drug_Name'], $row['Number_Of_Patients'],$row['Patient_Sex'] );
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