class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :post_id
      t.integer :user_id
      t.integer :how_point


      t.timestamps null: false
    end
  end
end
