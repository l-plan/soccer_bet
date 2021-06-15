class CreateBetTopplayers < ActiveRecord::Migration[6.1]
  def change
    create_table :bet_topplayers do |t|
      t.integer :participant_id
      t.integer :player_id

      t.timestamps
    end
    add_index :bet_topplayers, :participant_id
    add_index :bet_topplayers, :player_id
  end
end
