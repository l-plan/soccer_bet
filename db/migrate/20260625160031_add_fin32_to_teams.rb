class AddFin32ToTeams < ActiveRecord::Migration[7.2]
  def change
        add_column :teams, :fin32, :boolean
  end
end
