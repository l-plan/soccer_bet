class CreateMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :messages do |t|
      t.integer :participant_id
      t.integer :subject
      t.datetime :sent_on

      t.timestamps
    end
    add_index :messages, :participant_id
  end
end
