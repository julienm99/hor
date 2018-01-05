json.extract! activite, :id, :nom, :matiere, :groupe, :periodHor, :periodTache, :prof, :salle, :listeFoyers, :metaclass_id, :created_at, :updated_at
json.url activite_url(activite, format: :json)
