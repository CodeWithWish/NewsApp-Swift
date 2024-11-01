# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'NewsApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  source 'https://github.com/CocoaPods/Specs.git'
  platform :ios, '14.0'
  use_frameworks!
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings["IPHONEOS_DEPLOYMENT_TARGET"] = "13.0"
      end
    end
  end

    pod 'Swinject',                     '= 2.7.1'
    pod 'Alamofire'

  # Pods for NewsApp

  target 'NewsAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'NewsAppUITests' do
    # Pods for testing
  end

end
