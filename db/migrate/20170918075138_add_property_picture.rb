class AddPropertyPicture < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :pictures, :json
  end
end
