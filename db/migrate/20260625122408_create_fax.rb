class CreateFax < ActiveRecord::Migration[7.2]
  def change
    create_table :faxes do |t|

      t.integer :participant_id
      t.integer :stage
      t.integer :error
      t.string :message
      t.timestamps
    end
  end
end
