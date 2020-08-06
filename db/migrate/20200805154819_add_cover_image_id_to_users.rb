class AddCoverImageIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :cover_image_id, :string
  end
end
