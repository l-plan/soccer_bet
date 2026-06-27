class CreateFifaRankings < ActiveRecord::Migration[7.2]
  def change
    create_table :fifa_rankings do |t|
      t.integer :team_id
      t.float :points

      t.timestamps
    end
    add_index :fifa_rankings, :team_id
  end
end
