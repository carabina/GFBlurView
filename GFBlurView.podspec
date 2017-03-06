#
# Be sure to run `pod lib lint GFBlurView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GFBlurView'
  s.version          = '0.1.0'
  s.summary          = 'A simple tool to give view a blur'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Using UIVisualEffect is some how difficult or complicated, GFBlurView gives you a way to give one view a blur vision
                       DESC

  s.homepage         = 'https://github.com/guofengld/GFBlurView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'guofengld' => 'guofengld@gmail.com' }
  s.source           = { :git => 'https://github.com/guofengld/GFBlurView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/guofengld'

  s.ios.deployment_target = '8.0'

  s.source_files = 'GFBlurView/**/*'
  
  # s.resource_bundles = {
  #   'GFBlurView' => ['GFBlurView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Masonry'
end
