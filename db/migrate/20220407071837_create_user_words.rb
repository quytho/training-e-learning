class CreateUserWords < ActiveRecord::Migration[6.0]
  def change
    create_table :user_words do |t|
      t.boolean :is_status
      t.references :word, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

