platform :ios, '14.0'

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
      end
    end
end


target 'RedditClient' do
  pod 'SwiftLint'
  pod 'R.swift'
end