class CreateBloodClassificationSystems < ActiveRecord::Migration[5.2]
  def change
    create_table :blood_classification_systems, id: false do |t|
      # create primary key with integer not bigint
      t.integer :id, null: false, primary_key: true
      t.string :description, null: false
      t.string :name, limit: 50, null: false

      if ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
        t.column :created_at, :timestamptz, null: false
        t.column :updated_at, :timestamptz, null: false
      else
        t.timestamps null: false
      end
    end
  end
end
