module PanDomain
  module Human
    # Store information about blood clasification systems
    class BloodClassificationSystem < ActiveRecord::Base
      SYSTEMS = [
        {
          name: 'ABO',
          description: 'A system which group human blood with A, B, O, and AB.'
        },
        {
          name: 'Rhesus',
          description: 'A system which group human blood with Rh- and Rh+.'
        }
      ].freeze

      self.table_name = 'blood_classification_systems'

      validates :name, :description, presence: true

      validates_uniqueness_of :name

      has_many :blood_group_names

      class << self
        def abo
          @abo ||= find_by(name: 'ABO')
        end

        def rhesus
          @rhesus ||= find_by(name: 'Rhesus')
        end
      end
    end
  end
end
