class CreateBetGoals < ActiveRecord::Migration[7.2]
  def change
    create_table :bet_goals do |t|
      t.integer :participant_id
      t.integer :amount

      t.timestamps
    end
    add_index :bet_goals, :participant_id
  end
end
