

<?php

include ('header.php');

echo '<div class="placeholder"></div>';


require 'functions.php';

function renderSchool($image, $sch) {
    for ($i = 0; $i < count($sch); $i++) {
        echo '
        <div class="images">
        <img class="sch-img" src="imgs/'.$image.'">
        <div class="text-in-img">'. $sch.'
        </div>
        </div>';
    }
}

if(isset($_POST['search'])){

 $search = $_POST['search'];  
 $search = strtolower($search);

 $imgs = schoolImgs();
 $schools = schools();

 $found = false;


echo '<div class="schools d-flex flex-row mb-3">';

 for($i = 0; $i < count($schools); $i++) {
     $s = strtolower($schools[$i]);
     if(strpos($s, $search) !== false) {
         renderSchool($imgs[$i], $schools[$i]);
         $found = true;
     }
 }

 if($found === false) {
     echo '<div class="display-4 p-5"> School not found. </div>';
     echo '<div>
        <a href="all_schools.php">View all schools.</a>
    </div>';

 }

 echo '</div>';


}




include ('footer.php');


?>