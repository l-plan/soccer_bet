class CreateFifaFairPlayRankings < ActiveRecord::Migration[7.2]
  def change
    create_table :fifa_fair_play_rankings do |t|
      t.integer :team_id
      t.integer :points

      t.timestamps
    end
    add_index :fifa_fair_play_rankings, :team_id
  end
end
