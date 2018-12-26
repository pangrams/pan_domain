module PanDomain
  module Country
    # Store information about administrative street numbers
    class AdministrativeStreetNumber < ActiveRecord::Base
      self.table_name = 'administrative_street_numbers'

      validates :street_number, presence: true, uniqueness: {
        case_sensitive: false, scope: :administrative_street_name_id
      }

      belongs_to :administrative_street_name
    end
  end
end
