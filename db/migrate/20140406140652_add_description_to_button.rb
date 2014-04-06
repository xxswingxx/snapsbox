class AddDescriptionToButton < ActiveRecord::Migration
  def change
  	add_column :buttons, :description, :text
  end
end
