class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :name
      t.string :initials
      t.integer :team_id

      t.timestamps
    end
    add_index :players, :team_id
  end
end
