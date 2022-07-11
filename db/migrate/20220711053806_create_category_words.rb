class CreateCategoryWords < ActiveRecord::Migration[7.0]
  def change
    create_table :category_words, id: :string do |t|

      t.references :category, null: false, index: true, type: :string, foreign_key: true
      t.references :word, null: false, index: true, type: :string, foreign_key: true
      t.timestamps
    end
  end
end
