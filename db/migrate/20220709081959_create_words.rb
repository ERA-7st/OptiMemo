class CreateWords < ActiveRecord::Migration[7.0]
  def change
    create_table :words, id: :string do |t|

      t.references :user, null: false, index: true, type: :string, foreign_key: true
      t.string :word, null: false, default: ""
      t.string :converted_word, null: false, default: ""
      t.text   :content, null: false
      t.timestamps
    end
  end
end
