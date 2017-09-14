Pod::Spec.new do |s|
  s.name         = "DirectLine"
  s.version      = "1.0-alpha.2"
  s.summary      = "Swift client library for Microsoft Bot Framework's Direct Line protocol"
  s.description  = <<-DESC
    Loosely based on the official Javascript DirectLine client, it enables communication
    between your bot and your iOS app using a simple ReactiveX based interface.
  DESC
  s.homepage     = "https://github.com/gonzalezreal/DirectLine"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Guille Gonzalez" => "gonzalezreal@icloud.com" }
  s.social_media_url   = "https://twitter.com/gonzalezreal"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"
  s.tvos.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/gonzalezreal/DirectLine.git", :tag => s.version.to_s }
  s.source_files  = "Sources/**/*"
  s.frameworks  = "Foundation"
  s.dependency "RxSwift", "4.0.0-alpha.1"
  s.dependency "Starscream", "2.1.1"
end
