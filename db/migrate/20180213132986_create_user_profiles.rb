class CreateUserProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :user_profiles do |t|
      t.integer :user_id
      t.string :profile_picture
      t.string :address
      t.string :business_owner
      t.string :representative_name
      t.string :website

      t.timestamps
    end
  end
end
