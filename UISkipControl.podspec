Pod::Spec.new do |s|
s.name         = "UISkipController"
s.version      = "0.0.1"
s.summary      = "control VC skip, avoid crashes "
s.homepage     = "https://github.com/AKZHW/UISkipControl"
s.license      = "MIT"
s.author             = { "aksoftware" => "aksoftware@163.com" }
s.platform     = :ios, "7.0"
s.source       = { :git => "https://github.com/AKZHW/UISkipControl.git", :tag => "0.0.1" }
s.source_files  = "UISkipControl/**/*.{h,m}"
s.framework  = "UIKit"

