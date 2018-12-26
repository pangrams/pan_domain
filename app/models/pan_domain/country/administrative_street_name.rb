module PanDomain
  module Country
    # Store information about administrative street names
    class AdministrativeStreetName < ActiveRecord::Base
      self.table_name = 'administrative_street_names'

      validates :name, presence: true, uniqueness: {
        case_sensitive: false, scope: :administrative_division_id
      }

      belongs_to :administrative_division

      has_many :administrative_street_numbers
    end
  end
end
