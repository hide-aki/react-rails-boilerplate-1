class AddCreatedByToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :creator, references: :users, index: true, after: :status
  end
end
