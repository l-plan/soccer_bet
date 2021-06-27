class CreateBetPlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :bet_players do |t|
      t.integer :participant_id
      t.integer :player_id
      t.integer :stage
      t.integer :score

      t.timestamps
    end
    add_index :bet_players, :participant_id
  end
end
