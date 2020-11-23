<!DOCTYPE html>
<html>
  <head>
    <title>Carcinogens</title>
    <link rel="stylesheet" href="main.css">
  </head>
  <body>

    <header>
      <h1>Lung Cancer Clinical Trials</h1>
    </header>
    
    <p>The table below shows the frequency of female patients age 40 and above who have at least one single nucleotide polymorphism grouped by carcinogen name</p>

    <div id="table-wrap">

    <?php

    include_once 'db.php'; 
    //execute the query
    $stmt = $conn->query('select name, COUNT(*) AS count from Carcinogen natural join Exposes natural join Patients where age >= 40 and patient_ID in (select patient_ID from Has) GROUP BY name ORDER BY count DESC;');
    //set the fetch mode to associate array
    $stmt->setFetchMode(PDO::FETCH_ASSOC);
    // create result table headers
      echo "<table id='td' border=1>\n";
      echo "<tr><th>Carcinogen</th><th>Number_of_Patients</th></tr>\n";
      // print all rows using a loop
    while ($row = $stmt->fetch()) {
      printf("<tr><td>%s</td><td>%s</td></tr>\n", $row['name'], $row['count']);
    }
    echo "</table>\n";

    //disconnect from the database
    $stmt = null;
    $conn = null;S

     ?>
    </div>

     <a href="index.html"><button>Home Page</button></a>
  </body>
</html>