require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-kline"
  s.version      = package["version"]
  s.summary      = package["title"]
  s.description  = <<-DESC
                    #{package["description"]}
                   DESC
  s.homepage     = "https://github.com/thongdn-it/react-native-kline"
  s.license      = "MIT"
  s.platforms    = { :ios => "9.0" }
  s.source       = { :git => "https://github.com/thongdn-it/react-native-kline.git", :tag => "#{s.version}" }
  s.authors      = { "Thong Dang" => "thongdn.it@gmail.com" }
  s.source_files = "ios/**/*.{h,c,m,swift}"
  s.resources = ['ios/**/*.xib'] 
  s.requires_arc = true
  s.dependency "React"
end

