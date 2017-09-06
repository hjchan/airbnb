class AddUserDetails < ActiveRecord::Migration[5.1]
  def change
  	change_table :users do |t|
  		t.string :first_name, null: false
  		t.string :last_name, null: false
  		t.string :phone
  		t.date :birthday
  		t.string :gender
  		t.string :country
  	end
  end
end
