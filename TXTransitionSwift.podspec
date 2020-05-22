#
# Be sure to run `pod lib lint TXTransitionSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TXTransitionSwift'
  s.version          = '0.1.1'
  s.summary          = 'iOS转场动画Swift版本.'
  s.description      = <<-DESC
  由TX所开发的iOS转场动画Swift版本.
                       DESC
  s.homepage         = 'https://github.com/xtzPioneer/TXTransitionSwift'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '张雄' => 'xtz_pioneer@icloud.com' }
  s.source           = { :git => 'https://github.com/xtzPioneer/TXTransitionSwift.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'TXTransitionSwift/Classes/**/*.{swift}'
  s.public_header_files = 'Pod/Classes/**/*.{swift}'
  s.frameworks = 'UIKit'
end
