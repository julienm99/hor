class CreateActivites < ActiveRecord::Migration[5.1]
  def change
    create_table :activites do |t|
      t.string :nom
      t.string :metaclass
      t.string :cours
      t.string :groupe
      t.float :periodHor
      t.float :periodTache
      t.string :prof
      t.string :salle
      t.string :listeFoyers

      t.timestamps
    end
  end
end
