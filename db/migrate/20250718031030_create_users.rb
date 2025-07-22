class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.integer :student_no
      t.string :name
      t.string :role
      t.integer :password_digest

      t.timestamps
    end
  end
end
