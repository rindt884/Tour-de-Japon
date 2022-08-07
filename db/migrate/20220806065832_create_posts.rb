class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :customer_id, null: false
      t.string  :image,       null: false
      t.string  :title,       null: false
      t.text    :body,        null: false
      t.date    :rideday,     null: false
      t.time    :runtime,     null: false
      t.integer :mileage,     null: false

      t.timestamps
    end
  end
end
