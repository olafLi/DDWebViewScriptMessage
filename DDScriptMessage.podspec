#
# Be sure to run `pod lib lint DDScriptMessage.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'DDScriptMessage'
    s.version          = '1.0.1'
    s.summary          = 'DDScriptMessage is a lib support some simple function'

    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!

    s.description      = <<-DESC
    DDScriptMessage is a lib support a connection origin swift/oc with js
    DESC

    s.homepage         = 'https://git.citycloud.com.cn:3000/litengfei_winkind-tech.com/DDScriptMessage.git'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'olafLi' => 'litengfei@winkind-tech.com' }
    s.source           = { :git => 'https://git.citycloud.com.cn:3000/litengfei_winkind-tech.com/DDScriptMessage.git', :tag => s.version.to_s}
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'

    # s.public_header_files = 'Pod/Classes/**/*.h'
    s.frameworks = 'UIKit', 'MapKit'
    #    s.dependency 'XCGLogger', '~> 6'

    s.subspec 'Core' do | sub |
        sub.source_files = 'DDScriptMessage/Classes/Core/**/*.{swift}'
        sub.resource_bundles = {
            'DDScriptMessage' => ['DDScriptMessage/Assets/*.*'],
        }
    end
    
    s.subspec 'ScriptMessage' do | sub |
        sub.source_files = 'DDScriptMessage/Classes/ScriptMessage/*.swift'
        sub.resource_bundles = {
            'ScriptMessage' => ['DDScriptMessage/Classes/ScriptMessage/*.js']
        }
    end

    s.default_subspecs = 'Core'

end
