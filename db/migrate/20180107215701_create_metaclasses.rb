class CreateMetaclasses < ActiveRecord::Migration[5.1]
  def change
    create_table :metaclasses do |t|
      t.string :nom
      t.boolean :fixHor
      t.boolean :fixCedulables
      t.boolean :checked

      t.timestamps
    end
  end
end
