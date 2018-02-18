class CreateUserProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :user_profiles do |t|
      t.belongs_to :user, index: true, foreign_key: true, null: false
      t.attachment :profile_picture
      t.string :address
      t.string :brand
      t.string :business_owner
      t.string :representative_name
      t.string :website

      t.timestamps
    end
  end
end
