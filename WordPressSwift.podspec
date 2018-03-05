Pod::Spec.new do |s|
s.name             = 'WordPressSwift'
s.version          = '0.1.0'
s.summary          = 'Integrate WordPress on your app.'

s.description      = <<-DESC
Use WordPressSwift to integrate a WordPress blog on your own app.
You can retreive the categories of the blog, posts (you can filter by category), and more...
DESC

s.homepage         = 'https://github.com/Rubenfer/WordPressSwift'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Ruben Fernandez' => 'ruben.fdez@icloud.com' }
s.source           = { :git => 'https://github.com/Rubenfer/WordPressSwift.git', :tag => s.version.to_s }
s.social_media_url = 'https://twitter.com/RubenApps'

s.ios.deployment_target = '10.0'
s.source_files = 'WordPressSwift/WordpressSwift.swift'
  s.swift_version = '4.0'

end
