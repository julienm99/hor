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
    case "soumisCeduler":
      // Params reçus de l'URL du document
      const queryString = window.location.search;
      const urlParams = new URLSearchParams (queryString);
      const niv = urlParams.get('niv');
      const blocMC = urlParams.get('blocMC');

      // boutons radio enregistrement (sauve) + jour + nombre maximum de solutions
        var actif = document.querySelector('input[name="actif"]:checked').value;
        var jour = document.querySelector('input[name="jour"]:checked').value;
        var maxSols = document.getElementById('maxSols').value;

        var params = "execute=soumisCeduler&actif="+actif+"&blocMC="+blocMC+"&niv="+niv+"&jour="+jour+"&maxSols="+maxSols
        //window.alert("params = "+params);
        window.location.replace("/action?"+params);
      break;
    default:
      var path = "/blocMetaclasses?blocMC="+arguments[0];
      window.location.replace(path);
  }
}


