require 'xcodeproj'

project_path = 'Runner.xcodeproj'
project = Xcodeproj::Project.open(project_path)

# Get the main target
target = project.targets.first

# Update build settings for all configurations
target.build_configurations.each do |config|
  # Remove the problematic compiler flags
  config.build_settings['OTHER_CFLAGS'] = '$(inherited)'
  config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] = ['$(inherited)']
  
  # Update debugging settings
  config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
  
  # Ensure proper architecture settings
  if config.name == 'Debug'
    config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
  end
  
  # Update deployment target
  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
end

# Save the changes
project.save
