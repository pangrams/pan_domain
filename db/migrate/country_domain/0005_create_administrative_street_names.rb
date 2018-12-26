class CreateAdministrativeStreetNames < ActiveRecord::Migration[5.2]
  def change
    create_table :administrative_street_names do |t|
      t.integer :administrative_division_id, null: false, index: true
      t.string :name, null: false

      if ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
        t.column :created_at, :timestamptz, null: false
        t.column :updated_at, :timestamptz, null: false
      else
        t.timestamps null: false
      end
    end

    add_foreign_key :administrative_street_names, :administrative_divisions
  end
end
