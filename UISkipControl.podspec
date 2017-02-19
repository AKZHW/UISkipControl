Pod::Spec.new do |s|
s.name         = "UISkipController"
s.version      = "0.0.1"
s.summary      = "control VC skip, avoid crashes "
s.homepage     = "https://github.com/hujewelz/HUPhotoBrowser"
s.license      = "MIT"
s.author             = { "Jewelz Hu" => "hujewelz@163.com" }
s.platform     = :ios, "7.0"
s.source       = { :git => "https://github.com/hujewelz/HUPhotoBrowser.git", :tag => "0.0.2" }
s.source_files  = "HUPhotoBrowser", "HUPhotoBrowser/**/*.{h,m}"
s.framework  = "UIKit"
# s.frameworks = "SomeFramework", "AnotherFramework"
