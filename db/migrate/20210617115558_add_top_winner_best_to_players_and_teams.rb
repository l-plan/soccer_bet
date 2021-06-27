class AddTopWinnerBestToPlayersAndTeams < ActiveRecord::Migration[6.1]
  def change
    add_column :teams, :winner, :boolean
    add_column :teams, :red, :boolean
    add_column :players, :top, :boolean
    add_column :players, :best, :boolean
  end
end
