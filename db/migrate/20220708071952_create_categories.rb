class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories, id: :string do |t|

      t.references :user, null: false, index: { unique: true }, type: :string, foreign_key: true
      t.string :name, null: false, default: ""
      t.timestamps
    end
  end
end
