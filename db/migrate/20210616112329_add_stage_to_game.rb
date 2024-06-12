class AddStageToGame < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :stage, :integer
    add_index :games, :stage
  end
end
