class CreateSources < ActiveRecord::Migration
  def up
    create_table :sources do |t|
      t.integer :id
      t.string :name
      t.string :url
      t.string :category

      t.timestamps
    end
  end
  def down
    drop_table :sources
  end
end
