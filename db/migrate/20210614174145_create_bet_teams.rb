class CreateBetTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :bet_teams do |t|
      t.integer :participant_id
      t.integer :stage
      t.integer :team_id

      t.timestamps
    end
    add_index :bet_teams, :participant_id
    add_index :bet_teams, :team_id
    add_index :bet_teams, :stage
  end
end
