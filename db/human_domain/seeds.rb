require_dependency File.expand_path('../../app/models/pan_domain/human/blood_classification_system', __dir__)
require_dependency File.expand_path('../../app/models/pan_domain/human/blood_group_name', __dir__)

module PanDomain
  module Human
    if BloodClassificationSystem::SYSTEMS.size != BloodClassificationSystem.count
      BloodClassificationSystem::SYSTEMS.each do |system_params|
        BloodClassificationSystem.where(
          name: system_params[:name]
        ).first_or_create(description: system_params[:description])
      end
    end

    if BloodGroupName::GROUP_NAMES.size != BloodGroupName.count
      BloodGroupName::GROUP_NAMES.each do |group_name_params|
        system = BloodClassificationSystem.find_by(name: group_name_params[:system_name])

        BloodGroupName.where(
          name: group_name_params[:name], symbol: group_name_params[:symbol]
        ).first_or_create(blood_classification_system: system)
      end
    end
  end
end
