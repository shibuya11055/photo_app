class CreatePhotos < ActiveRecord::Migration[8.0]
  def change
    create_table :photos do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false, comment: '写真タイトル'

      t.timestamps
    end
  end
end
