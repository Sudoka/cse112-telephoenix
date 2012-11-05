class CreateTags < ActiveRecord::Migration
  def up
    create_table :tags do |t|
      t.integer :id
      t.references :phone
      t.string :key
      t.string :value

      t.timestamps
    end
  end
  def down
    drop_table :tags
  end
end
