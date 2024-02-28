class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :location
      t.references :users, null: false, foreign_key: true

      t.timestamps
    end
  end
end