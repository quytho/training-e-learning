class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
