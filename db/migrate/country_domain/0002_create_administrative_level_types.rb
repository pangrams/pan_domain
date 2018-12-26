class CreateAdministrativeLevelTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :administrative_level_types do |t|
      t.integer :country_id, null: false, index: true
      t.integer :level, limit: 2, null: false
      t.string :name, null: false

      if ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
        t.column :created_at, :timestamptz, null: false
        t.column :updated_at, :timestamptz, null: false
      else
        t.timestamps null: false
      end
    end

    add_foreign_key :administrative_level_types, :countries
  end
end
