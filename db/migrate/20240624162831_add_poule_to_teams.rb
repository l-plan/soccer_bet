class AddPouleToTeams < ActiveRecord::Migration[7.1]
  def change
    add_column :teams, :poule, :string
    add_column :teams, :poule_rank, :integer
  end
end
