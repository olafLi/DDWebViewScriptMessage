#
# Be sure to run `pod lib lint DDScriptMessage.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'DDScriptMessage'
    s.version          = '0.0.1'
    s.summary          = 'DDScriptMessage is a lib support some simple function'

    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!

    s.description      = <<-DESC
    DDScriptMessage is a lib support a connection origin swift/oc with js
    DESC

    s.homepage         = 'https://github.com/olafLi/DDWebViewScriptMessage.git'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'olafLi' => 'litengfei@winkind-tech.com' }
    s.source           = { :git => 'https://github.com/olafLi/DDWebViewScriptMessage.git', :tag => s.version.to_s}
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'

    # s.public_header_files = 'Pod/Classes/**/*.h'
    s.frameworks = 'UIKit', 'MapKit'

    s.subspec 'Core' do | sub |
        sub.source_files = 'DDScriptMessage/Classes/Core/**/*.{swift}'
        sub.resource_bundles = {
            'DDScriptMessage' => ['DDScriptMessage/Assets/*.*'],
        }
    end
    
    s.subspec 'AlertScriptMessage' do | sub |
        sub.source_files = 'DDScriptMessage/Classes/ScriptMessage/AlertScriptMessage/*.swift'
        sub.resource_bundles = {
            'AlertScriptMessage' => ['DDScriptMessage/Classes/ScriptMessage/AlertScriptMessage/*.js']
        }
    end

    s.subspec 'InputViewScriptMessage' do | sub |
        sub.source_files = 'DDScriptMessage/Classes/ScriptMessage/InputViewScriptMessage/*.swift'
        sub.resource_bundles = {
            'InputViewScriptMessage' => ['DDScriptMessage/Classes/ScriptMessage/InputViewScriptMessage/*.js']
        }
    end
    
    s.default_subspecs = 'Core'

end
