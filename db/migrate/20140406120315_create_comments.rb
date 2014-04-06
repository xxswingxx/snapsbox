class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.text :body
    	t.references :button
    	t.references :user
        t.timestamps
    end

   	add_index :comments, :user_id
   	add_index :comments, :button_id
  end
end
