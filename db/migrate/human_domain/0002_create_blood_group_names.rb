class CreateBloodGroupNames < ActiveRecord::Migration[5.2]
  def change
    create_table :blood_group_names, id: false do |t|
      # create primary key with integer not bigint
      t.integer :id, null: false, primary_key: true
      t.integer :blood_classification_system_id, null: false, index: true
      t.string :name, limit: 10, null: false
      t.string :symbol, limit: 10, null: false

      if ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
        t.column :created_at, :timestamptz, null: false
        t.column :updated_at, :timestamptz, null: false
      else
        t.timestamps null: false
      end
    end

    add_foreign_key :blood_group_names, :blood_classification_systems
  end
end
