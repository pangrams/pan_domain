class CreateAdministrativeStreetNumbers < ActiveRecord::Migration[5.2]
  def change
    create_table :administrative_street_numbers do |t|
      t.integer :administrative_street_name_id, null: false
      t.string :street_number, null: false

      if ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
        t.column :created_at, :timestamptz, null: false
        t.column :updated_at, :timestamptz, null: false
      else
        t.timestamps null: false
      end
    end

    add_index :administrative_street_numbers, :administrative_street_name_id,
              name: 'index_administ_street_numbers_on_administrative_street_name_id'
    add_foreign_key :administrative_street_numbers, :administrative_street_names
  end
end
