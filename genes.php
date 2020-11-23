<!DOCTYPE html>
<html>
  <head>
    <title>Gene Drug Cancer</title>
    <link rel="stylesheet" href="main.css">
  </head>
  <body>
     <header>
      <h1>Lung Cancer Clinical Trials</h1>
    </header>


    <p>The table below shows the targeted genes by each drug along with the diagnosed lung cancer </p>

    <div id="table-wrap">

    <?php
    
    include_once 'db.php';
    //execute the query
    $stmt = $conn->query('select Gene.name as Target_Gene_Name, Drug_Procedure.name as Acting_Drug_Name, Lung_Cancer.cancer_name as Diagnosed_Lung_Cancer from Gene left join Interacts on Gene.gene_ID = Interacts.gene_ID left join Drug_Procedure on Interacts.DP_ID =Drug_Procedure.DP_ID left join Used_In on Drug_Procedure.DP_ID = Used_In.DP_ID left join Clinical_Trials on Used_In.CT_ID = Clinical_Trials.CT_ID left join Lung_Cancer on Clinical_Trials.cancer_ID = Lung_Cancer.cancer_ID where Lung_Cancer.cancer_ID IS NOT NULL;');
    //set the fetch mode to associate array
    $stmt->setFetchMode(PDO::FETCH_ASSOC);
    // create result table headers
      echo "<table id='td' border=1>\n";
      echo "<tr><th>Target_Gene_Name</th><th>Acting_Drug_Name</th><th>Diagnosed_Lung_Cancer</th></tr>\n";
      // print all rows using a loop
    while ($row = $stmt->fetch()) {
      printf("<tr><td>%s</td><td>%s</td><td>%s</td></tr>\n", $row['Target_Gene_Name'], $row['Acting_Drug_Name'],$row['Diagnosed_Lung_Cancer'] );
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