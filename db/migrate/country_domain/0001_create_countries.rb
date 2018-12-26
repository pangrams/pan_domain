class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries, id: false do |t|
      # create primary key with integer not bigint
      t.integer :id, null: false, primary_key: true
      t.string :name, null: false

      if ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
        t.column :created_at, :timestamptz, null: false
        t.column :updated_at, :timestamptz, null: false
      else
        t.timestamps null: false
      end
    end
  end
end
