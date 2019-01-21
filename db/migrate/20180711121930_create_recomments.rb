class CreateRecomments < ActiveRecord::Migration
  def change
    create_table :recomments do |t|
      t.text :content
      t.integer :comment_id
      t.integer :user_id
      t.string :name

      t.timestamps null: false
    end
  end
end
