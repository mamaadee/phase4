class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.references :family, foreign_key: true
      t.date :date_of_birth
      t.integer :rating
      t.boolean :active

      t.timestamps
    end
  end
end
