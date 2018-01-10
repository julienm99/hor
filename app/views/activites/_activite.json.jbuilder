json.extract! activite, :id, :nom, :identifiantmc, :cours, :groupe, :periodes, :periodesTache, :semestre, :prof, :salle, :listeFoyers, :metaclass_id, :created_at, :updated_at
json.url activite_url(activite, format: :json)
