Pod::Spec.new do |s|
  s.name             = 'zikzak_useragent_ios'
  s.version          = '1.1.0'
  s.summary          = 'iOS implementation of ZikZak UserAgent plugin for Flutter.'
  s.description      = <<-DESC
                       The iOS implementation of zikzak_useragent plugin that provides
                       native UserAgent extraction using WKWebView with Safari compatibility.
                       Built for the ZIKZAK ecosystem with zero compromise on performance.
                       DESC
  s.homepage         = 'https://github.com/arrrrny/zikzak_useragent'
  s.license          = { :type => 'Apache-2.0', :text => <<-LICENSE
                           Licensed under the Apache License, Version 2.0 (the "License");
                           you may not use this file except in compliance with the License.
                           You may obtain a copy of the License at

                               http://www.apache.org/licenses/LICENSE-2.0

                           Unless required by applicable law or agreed to in writing, software
                           distributed under the License is distributed on an "AS IS" BASIS,
                           WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
                           See the License for the specific language governing permissions and
                           limitations under the License.
                         LICENSE
                       }
  s.author           = { 'ARRRRNY' => 'arrrrny@zuzu.dev' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
