class CreateDeadlines < ActiveRecord::Migration[7.0]
  def change
    create_table :deadlines do |t|
      t.integer :initial_kilometer, default: 0
      t.integer :final_kilometer
      t.integer :deadline
      t.references :carrier, null: false, foreign_key: true

      t.timestamps
    end
  end
end
