class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :login_id, null: false, comment: 'ログインID'
      t.string :password_digest, null: false, comment: 'ログインパスワード'

      t.timestamps
    end
  end
end
