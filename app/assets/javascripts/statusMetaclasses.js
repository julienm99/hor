
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


function pageWeb() {
  if (arguments[0] == "accueil")        { window.location.replace("/"); };
  if (arguments[0] == "backbone")       { window.location.replace("/backbone"); };
  if (arguments[0] == "nivS5")          { window.location.replace("/nivS5"); };
  if (arguments[0] == "metaclassesEPS") { window.location.replace("/metaclassesEPS"); };
}


