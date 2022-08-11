
source 'https://cdn.cocoapods.org'
source 'https://git.wemomo.com/ios/Specs.git'
source 'https://git.wemomo.com/next/Specs.git'
source 'https://git.wemomo.com/cv/Podspecs.git'
source 'https://git.wemomo.com/base/Specs.git'
source 'https://git.wemomo.com/live_ios/Podspecs.git'
source 'https://git.wemomo.com/live/Podspecs.git'
source 'https://git.wemomo.com/fex-pods/Podspecs.git'
source 'https://git.wemomo.com/VFX/Specs.git'
source 'https://git.wemomo.com/ios/BinarySpec.git'
source 'https://github.com/aliyun/aliyun-specs.git'

inhibit_all_warnings!
use_modular_headers!
use_frameworks! :linkage => :static

install! 'cocoapods',
:deterministic_uuids => false,
:generate_multiple_pod_projects => true,

:disable_input_output_paths => true,
:preserve_pod_file_structure => true,
:warn_for_unused_master_specs_repo => false

platform :ios, '12.0'

project 'SwiftBuild_demo'


target :SwiftBuild_demo do
  pod 'MMSUIBaseFoundation', :git => 'https://git.wemomo.com/ios/BaseFoundationLayer/MMSUIBaseFoundation.git', :branch => 'jenkins_test'
#    pod 'MMSUIBaseFoundation',
    pod 'MMSBaseFoundation', '0.0.13'
#    pod 'SVGAPlayer'

end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['OTHER_SWIFT_FLAGS'] ||= '-Xfrontend -debug-time-function-bodies'
      end
    end
  end
end

