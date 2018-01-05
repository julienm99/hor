class CreateMetaclasses < ActiveRecord::Migration[5.1]
  def change
    create_table :metaclasses do |t|
      t.string :nom
      t.boolean :horFix
      t.boolean :FixCedulables
      t.boolean :checked
      t.string :listClasses

      t.timestamps
    end
  end
end
