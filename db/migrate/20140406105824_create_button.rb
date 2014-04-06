class CreateButton < ActiveRecord::Migration
  def change
    create_table :buttons do |t|
      t.references :team
      t.references :user
      t.string :title
      t.string :url
      t.timestamps
    end

    add_index :buttons, :user_id
    add_index :buttons, :team_id
  end
end
