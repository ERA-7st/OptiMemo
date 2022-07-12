class CreateScores < ActiveRecord::Migration[7.0]
  def change
    create_table :scores, id: :string do |t|

      t.references :word, null: false, index: { unique: true }, type: :string, foreign_key: true
      t.integer :correct_count, null: false, unsigned: true, default: 0
      t.integer :wrong_count, null: false, unsigned: true, default: 0
      t.integer :phase, null: false, unsigned: true, default: 0
      t.integer :days_left, null: false, unsigned: true, default: 1
      t.timestamps
    end
  end
end
