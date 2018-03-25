class CreateSiteOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :site_options do |t|
      t.string :key
      t.text :value

      t.timestamps
    end
    add_index :site_options, :key, unique: true
  end
end
