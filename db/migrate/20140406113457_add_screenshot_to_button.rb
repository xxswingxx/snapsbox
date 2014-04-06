class AddScreenshotToButton < ActiveRecord::Migration
  def change
  	add_column :buttons, :screenshot, :string
  end
end
