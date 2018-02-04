Rails.application.routes.draw do
  
  resources :activites
  resources :metaclasses
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'hor#index'
  
  if true #~ routes: TOP nav_bar  ------------------------------------------
    get 'backbone',          to: 'hor#backbone'
    get 'choixMatiere',      to: 'hor#choixMatiere'
    
    get 'miseAjour',         to: 'hor#miseAjour'
    
    get 'deselectionner',    to: 'hor#deselectionner'
    
    get 'infoHoraire',       to: 'hor#infoHoraire'
    get 'infoCedulables',    to: 'hor#infoCedulables'
  end
  
  if true #~ routes: BOTTOM nav_bar  ---------------------------------------
    get 'valider',           to: 'hor#valider'
    get 'invalider',         to: 'hor#invalider'
    get 'filtrer',           to: 'hor#filtrer'
    get 'fixerHoraire',      to: 'hor#fixerHoraire'
  end

  if true #~ routes: COURS/ACTIVITES/MATIERE -------------------------------
    get 'coursEPS',  to: 'hor#coursEPS'
    get 'coursART',  to: 'hor#coursART'
    get 'coursANG',  to: 'hor#coursANG'
    get 'coursFRA',  to: 'hor#coursFRA'
    get 'coursMAT',  to: 'hor#coursMAT'
    get 'coursSCT',  to: 'hor#coursSCT'
  end
  
  if true #~ routes: NIVEAUX -----------------------------------------------
    get 'nivS1',  to: 'hor#nivS1'
    get 'nivS2',  to: 'hor#nivS2'
    get 'nivS3',  to: 'hor#nivS3'
    get 'nivS4',  to: 'hor#nivS4'
    get 'nivS5',  to: 'hor#nivS5'
  end
  
  if true #~ routes: GROUPES -----------------------------------------------
    #~ get 'gr101',  to: 'hor#gr101'
    #~ get 'gr102',  to: 'hor#gr102'
    #~ get 'gr103',  to: 'hor#gr103'
    #~ get 'gr104',  to: 'hor#gr104'
    #~ get 'gr105',  to: 'hor#gr105'
    #~ get 'gr106',  to: 'hor#gr106'
    #~ get 'gr107',  to: 'hor#gr107'
    #~ get 'gr108',  to: 'hor#gr108'
    #~ get 'gr109',  to: 'hor#gr109'
    #~ get 'gr110',  to: 'hor#gr110'
    #~ get 'gr111',  to: 'hor#gr111'

    get 'gr21',  to: 'hor#gr21'
    #~ get 'gr22',  to: 'hor#gr22'
    #~ get 'gr23',  to: 'hor#gr23'
    #~ get 'gr24',  to: 'hor#gr24'
    #~ get 'gr25',  to: 'hor#gr25'
    #~ get 'gr26',  to: 'hor#gr26'
    #~ get 'gr27',  to: 'hor#gr27'
    #~ get 'gr28',  to: 'hor#gr28'
    #~ get 'gr29',  to: 'hor#gr29'

    get 'gr31',  to: 'hor#gr31'
    get 'gr32',  to: 'hor#gr32'
    get 'gr33',  to: 'hor#gr33'
    get 'gr34',  to: 'hor#gr34'
    get 'gr35',  to: 'hor#gr35'
    get 'gr36',  to: 'hor#gr36'
    get 'gr37',  to: 'hor#gr37'
    get 'gr38',  to: 'hor#gr38'
    get 'gr39',  to: 'hor#gr39'

    get 'gr41',  to: 'hor#gr41'
    get 'gr42',  to: 'hor#gr42'
    get 'gr43',  to: 'hor#gr43'
    get 'gr44',  to: 'hor#gr44'
    get 'gr45',  to: 'hor#gr45'
    get 'gr46',  to: 'hor#gr46'
    get 'gr47',  to: 'hor#gr47'
    get 'gr48',  to: 'hor#gr48'
    get 'gr49',  to: 'hor#gr49'

    get 'gr51',  to: 'hor#gr51'
    get 'gr52',  to: 'hor#gr52'
    get 'gr53',  to: 'hor#gr53'
    get 'gr54',  to: 'hor#gr54'
    get 'gr55',  to: 'hor#gr55'
    get 'gr56',  to: 'hor#gr56'
    get 'gr57',  to: 'hor#gr57'
    get 'gr58',  to: 'hor#gr58'
    get 'gr59',  to: 'hor#gr59'
  end

end
