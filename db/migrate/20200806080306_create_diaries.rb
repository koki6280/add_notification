class CreateDiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :diaries do |t|
      t.text :body
      t.string :body_image_id
      t.string :exercise
      t.string :sleep
      t.string :cigarette
      t.string :drinking

      t.timestamps
    end
  end
end
