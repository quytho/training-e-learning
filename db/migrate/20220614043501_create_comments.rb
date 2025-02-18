class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :parent_id
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.timestamps
    end
  end
end
