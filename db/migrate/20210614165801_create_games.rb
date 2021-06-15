class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.integer :nr
      t.datetime :date
      t.integer :home_id
      t.integer :away_id
      t.integer :score_home
      t.integer :score_away

      t.timestamps
    end
    add_index :games, :nr
    add_index :games, :date
    add_index :games, :home_id
    add_index :games, :away_id
  end
end
