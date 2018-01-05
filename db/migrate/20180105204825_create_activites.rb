class CreateActivites < ActiveRecord::Migration[5.1]
  def change
    create_table :activites do |t|
      t.string :nom
      t.string :matiere
      t.string :groupe
      t.float :periodHor
      t.float :periodTache
      t.string :prof
      t.string :salle
      t.string :listeFoyers
      t.references :metaclass, foreign_key: true

      t.timestamps
    end
  end
end
