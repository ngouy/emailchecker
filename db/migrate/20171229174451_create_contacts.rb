class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :email
      t.boolean :is_valid

      t.timestamps
    end
  end
end
