Pod::Spec.new do |s|
  s.name             = 'zikzak_useragent_macos'
  s.version          = '1.1.0'
  s.summary          = 'macOS implementation of ZikZak UserAgent plugin for Flutter.'
  s.description      = <<-DESC
                       The macOS implementation of zikzak_useragent plugin that provides
                       native UserAgent extraction using WKWebView.
                       DESC
  s.homepage         = 'https://github.com/arrrrny/zikzak_useragent'
  s.license          = { :type => 'Apache-2.0', :file => '../LICENSE' }
  s.author           = { 'ARRRRNY' => 'arrrrny@zuzu.dev' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'
  s.platform = :osx, '10.14'

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
