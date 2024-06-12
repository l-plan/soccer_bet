class CreateBetGames < ActiveRecord::Migration[7.1]
  def change
    create_table :bet_games do |t|
      t.integer :participant_id
      t.integer :game_id
      t.integer :home
      t.integer :away
      t.integer :score

      t.timestamps
    end
    add_index :bet_games, :participant_id
  end
end
