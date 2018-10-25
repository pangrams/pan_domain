module PanDomain
  module Human
    # Store information about blood groups
    class BloodGroupName < ActiveRecord::Base
      GROUP_NAMES = [
        { system_name: 'ABO', name: 'A', symbol: 'A' },
        { system_name: 'ABO', name: 'B', symbol: 'B' },
        { system_name: 'ABO', name: 'O', symbol: 'O' },
        { system_name: 'ABO', name: 'AB', symbol: 'AB' },
        { system_name: 'Rhesus', name: 'Rhesus +', symbol: 'Rh+' },
        { system_name: 'Rhesus', name: 'Rhesus -', symbol: 'Rh-' }
      ].freeze

      self.table_name = 'blood_group_names'

      validates :name, :symbol,
                presence: true,
                uniqueness: {
                  scope: :blood_classification_system_id, case_sensitive: false
                }

      belongs_to :blood_classification_system
    end
  end
end
