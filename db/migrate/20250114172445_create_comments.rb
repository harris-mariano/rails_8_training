class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.references :article, null: false, foreign_key: true

      t.timestamps
    end
  end
end
