class CreatePoems < ActiveRecord::Migration[5.1]
  def change
    create_table :poems do |t|
      t.string :title
      t.string :content
      t.string :date
      t.integer :user_id
      t.integer :category_id
    end
  end
end
