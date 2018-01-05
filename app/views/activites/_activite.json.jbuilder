json.extract! activite, :id, :nom, :metaclass, :cours, :groupe, :periodHor, :periodTache, :prof, :salle, :listeFoyers, :created_at, :updated_at
json.url activite_url(activite, format: :json)
