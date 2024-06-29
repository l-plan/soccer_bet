class AddPouleToBetTeams < ActiveRecord::Migration[7.1]
  def change
    add_column :bet_teams, :poule, :string
    add_column :bet_teams, :poule_rank, :integer
  end
end
