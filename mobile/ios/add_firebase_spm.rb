#!/usr/bin/env ruby

require 'xcodeproj'

# Path to your Xcode project
project_path = 'Runner.xcodeproj'
project = Xcodeproj::Project.open(project_path)

# Find the Runner target
target = project.targets.find { |t| t.name == 'Runner' }

# Add Firebase packages
packages = [
  ['https://github.com/firebase/firebase-ios-sdk.git', '10.25.0']
]

# Get the package configurations
package_configs = packages.map do |url, version|
  {
    url: url,
    requirement: {
      kind: :exact,
      version: version
    }
  }
end

# Add the package dependencies
package_configs.each do |config|
  project.root_object.package_references << project.new(
    Xcodeproj::Project::Object::XCRemoteSwiftPackageReference,
    config
  )
end

# Save the project
project.save
