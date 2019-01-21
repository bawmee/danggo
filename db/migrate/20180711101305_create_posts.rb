class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :category
      t.string :color
      t.string :vote_type
      t.integer :user_id
      t.string :name
      t.string :title
      t.text :content
      t.float :time
      t.boolean :vote
      t.string :image_url, :default => ""

      t.timestamps null: false
    end
  end
end
