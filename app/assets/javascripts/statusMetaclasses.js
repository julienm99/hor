
function metaclassesChoisies() {
    var mc = document.forms["listeMetaclasses"];
    var i, mcChecked = "";
  
    for (i = 0; i < mc.length; i++) {
        if (mc[i].checked) {
            mcChecked +=  mc[i].value + " ";
        }
      }
    document.getElementById("choixMetaclasses").innerHTML = mcChecked;
      
    affiche();
}

function affiche() {
      document.getElementById("affiche").innerHTML;

}


function accueil() {
  // NE FONCTIONNE PAS
      window.location.replace("http://localhost:3000/");

}
