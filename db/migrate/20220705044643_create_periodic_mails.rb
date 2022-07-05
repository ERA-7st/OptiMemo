class CreatePeriodicMails < ActiveRecord::Migration[7.0]
  def change
    create_table :periodic_mails, id: :string do |t|

      t.references :user, null: false, index: { unique: true }, type: :string, foreign_key: true
      t.boolean :sun, default: true, null: false
      t.boolean :mon, default: false, null: false
      t.boolean :tue, default: false, null: false
      t.boolean :wed, default: false, null: false
      t.boolean :thu, default: false, null: false
      t.boolean :fri, default: false, null: false
      t.boolean :sat, default: false, null: false
      t.timestamps
    end
  end
end
