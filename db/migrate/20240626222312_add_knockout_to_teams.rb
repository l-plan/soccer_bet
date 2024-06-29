class AddKnockoutToTeams < ActiveRecord::Migration[7.1]
  def change
    add_column :teams, :fin16, :boolean
    add_column :teams, :fin8, :boolean
    add_column :teams, :fin4, :boolean
    add_column :teams, :fin2, :boolean
  end
end
