module PanDomain
  module Country
    # Store information about countries
    class Country < ActiveRecord::Base
      self.table_name = 'countries'

      validates :name, presence: true, uniqueness: { case_sensitive: false }

      has_many :administrative_level_types
    end
  end
end
