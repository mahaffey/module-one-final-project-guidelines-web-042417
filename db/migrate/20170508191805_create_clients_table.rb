class CreateClientsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.string :first_name
      t.string :last_name
      t.string :company, default: nil
      t.integer :phone
      t.string :email
      t.string :address
    end
  end
end
