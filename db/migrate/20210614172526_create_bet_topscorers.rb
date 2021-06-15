class CreateBetTopscorers < ActiveRecord::Migration[6.1]
  def change
    create_table :bet_topscorers do |t|
      t.integer :participant_id
      t.integer :player_id

      t.timestamps
    end
    add_index :bet_topscorers, :participant_id
    add_index :bet_topscorers, :player_id
  end
end
