require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = package['name']
  s.version      = package['version']
  s.summary      = package['description']
  s.license      = package['license']
  s.description  = <<-DESC
                  react-native-color-lens
                   DESC
  s.homepage     = "https://github.com/keithbmccall/react-native-color-lens"
  s.authors      = package['author']
  s.platform     = :ios, "9.0"
  s.source       = { :git => "git+https://github.com/keithbmccall/react-native-color-lens.git", :tag => "v#{s.version}" }
  s.source_files  = "ios/**/*.{h,m,swift}"
  s.requires_arc = true
  s.swift_version = '5.0'
  s.dependency 'React'
  s.frameworks = 'UIKit'
end
