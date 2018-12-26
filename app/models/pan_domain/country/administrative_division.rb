module PanDomain
  module Country
    # Store information about administrative divisions
    class AdministrativeDivision < ActiveRecord::Base
      self.table_name = 'administrative_divisions'

      validates :name, presence: true, uniqueness: {
        case_sensitive: false, scope: :administrative_level_type_id
      }

      belongs_to :administrative_level_type

      has_many :administrative_street_names
    end
  end
end
