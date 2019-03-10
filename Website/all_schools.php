


<?php include ('header.php'); ?>


<div class="placeholder"></div>

<p class="display-4 text-center mx-5" id="schools-header">Schools</p>


<div class="schools d-flex flex-row mt-3"> 


<?php

require 'functions.php';
$schools = schools();
$img = schoolImgs();

for ($i = 0; $i < 3; $i++) {
    echo '
    <div class="images">
    <img class="sch-img" src="imgs/'.$img[$i].'">
    <div class="text-in-img">'. $schools[$i].'
    </div>
    </div>';
}

?>

</div>

<div class="schools d-flex flex-row mb-3">

<?php

    for ($i = 3; $i < count($schools); $i++) {
        echo '
        <div class="images">
        <img class="sch-img" src="imgs/'.$img[$i].'">
        <div class="text-in-img">'. $schools[$i].'
        </div>
        </div>';
    }

?>

</div>



<?php include ('footer.php'); ?>




