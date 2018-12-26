module PanDomain
  module Country
    # Store information about administrative level types
    class AdministrativeLevelType < ActiveRecord::Base
      self.table_name = 'administrative_level_types'
      
      validates :level, presence: true
      validates :name, presence: true, uniqueness: {
        case_sensitive: false, scope: [:country_id]
      }

      belongs_to :country

      has_many :administrative_divisions
    end
  end
end
