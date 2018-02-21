class CreateMetaclasses < ActiveRecord::Migration[5.1]
  def change
    create_table :metaclasses do |t|
      t.string :nom
      t.string :status
      t.string :niveau
      t.string :listeActivites

      t.timestamps
    end
  end
end
