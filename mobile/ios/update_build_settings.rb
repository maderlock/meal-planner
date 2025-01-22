#!/usr/bin/env ruby

require 'xcodeproj'

# Path to your Xcode project
project_path = 'Runner.xcodeproj'
project = Xcodeproj::Project.open(project_path)

# Find the Runner target
target = project.targets.find { |t| t.name == 'Runner' }

# Update build settings for all configurations
target.build_configurations.each do |config|
  # Enable modules for all targets
  config.build_settings['CLANG_ENABLE_MODULES'] = 'YES'
  
  # Allow non-modular includes in framework modules
  config.build_settings['CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES'] = 'YES'
  
  # Enable module definition
  config.build_settings['DEFINES_MODULE'] = 'YES'
  
  # Set header search paths
  config.build_settings['HEADER_SEARCH_PATHS'] = [
    '$(inherited)',
    '"${PODS_ROOT}/Headers/Public"',
    '"${PODS_ROOT}/Headers/Public/Firebase"'
  ]
  
  # Set framework search paths
  config.build_settings['FRAMEWORK_SEARCH_PATHS'] = [
    '$(inherited)',
    '"${PODS_CONFIGURATION_BUILD_DIR}/FirebaseCore"',
    '"${PODS_CONFIGURATION_BUILD_DIR}/FirebaseAuth"',
    '"${PODS_CONFIGURATION_BUILD_DIR}/GoogleUtilities"'
  ]
end

# Save the project
project.save
