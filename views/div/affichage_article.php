 <?php
 function affichage_article ($affiche, $aff_cat) { /*var_dump($affiche); die('isma');*/ ?>
      <div class="container" style="margin-top: 5%;max-width: 60%;">
        <nav class="navbar navbar-light bg-light">
        <input class="form-control mr-sm-2" id="test1" type="search" aria-label="Search" placeholder="Rechercher..." name="" style="max-width: 20%;">
        <?php
          while($donneesAffichage = $aff_cat->fetch()){
        ?>
        <h3><?=$donneesAffichage['nom']?></h3>
        <?php
          };
        ?>
        <select class="custom-select" id="testJs" name="trier" style="max-width: 20%;">
          <option>Trier par</option>
          <option id="test2" value="Croissant" > Prix Croissant</option>
          <option id="test3" value="Décroissant" >Prix Décroissant</option>
        </select>
        </nav>
          <div class="row" id="lists" style="margin-top: 3%;">
          <?php for($i=0; $i<count($affiche);$i++ ) { ?>
          <div id="card<?=$i?>" data-price="<?= $affiche[$i][2] ?>" class="col-md-4">
            <div class="card mb-4 shadow-sm"
            <?php 
              if($affiche[$i][5] != "dispo") { 
               echo "style='background: linear-gradient(45deg, white 25%, #E8E8E8  25%, #E8E8E8  50%, white 50%, white 75%,#E8E8E8  75%); background-size: 100px 100px;'";
              }
              ?>
              >
              <div class="card-header" >
      
                <center><h4 id="titre<?=$i?>"><?= $affiche[$i][0] ?></h4></center>
              </div>
              <div class="card-body" style="max-height: 325px;min-height: 325px;">
              <?php
                  if($affiche[$i]['7']>0) {
                      echo"<span class=\"badge badge-danger\" style=\"float:right;\">".$affiche[$i]['7']." % de réduction</span>";
                  }?>
              <center>
                <img style="width: 230px" src="views/img/<?= $affiche[$i][4] ?>" class="card-img-top"  alt="Card image cap">
              </center>
                <p id="text<?=$i?>" class="card-text"><?= $affiche[$i][1] ?></p>
              </div>
              <div class="card-footer" >

                <div class="d-flex justify-content-between align-items-center">
                    <a href="index.php?page=<?=$_GET['page']?>&rub=<?=$_GET['rub']?>&cat=<?=$affiche[$i][6] ?>&art=<?=$affiche[$i][3]?>" class="btn btn-danger">Louer</a>
                    <a class="text-muted"><?php echo $affiche[$i][2]-($affiche[$i]['7']/100)*$affiche[$i][2]."€/jour </a>";?>
                    <button type="button"
                    <?php 
                    if($affiche[$i][5] != "dispo") { 
                      echo "class=\"btn btn-outline-danger disabled \">Non diponible";        
                    }else{
                      echo"class=\"btn btn-outline-success disabled \">Diponible";
                    }

               ?></button>
                  </div>
              </div>
            </div>
          </div>
        <?php } ?>
          </div>
      </div> 
</div>
   <script>$('#test1').keyup(function(){recherche(<?= $i; ?>);});</script>
   <script>$('#testJs').change(function(){tri(<?=$i;?>);});</script>

<?php
}
?>

