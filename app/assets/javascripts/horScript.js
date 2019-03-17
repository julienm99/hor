function horaireJDLM() {
    window.location.replace("/");
}

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
  
  switch(arguments[0]) {
    case "4-en_traitement" :
    case "infoHoraire" :
    case "infoCedulables" :
    case "invalider":
    case "valider":
    case "index":
    case "BaseDeDonnees":
      window.location.replace("/");
      break;
    case "EPS":
      var path = "/blocMetaclasses?blocMC="+arguments[0];
      window.location.replace(path);
      break;
    default:
      var path = "/blocMetaclasses?blocMC="+arguments[0];
      window.location.replace(path);
  }
}


