Pod::Spec.new do |s|
  s.name             = 'SBRunLoop'
  s.version          = '0.1.0'
  s.summary          = 'CADisplayLink wrapper'

  s.description      = <<-DESC
Wrapper for CADisplayLink for easily managing loops with variable or fixed time steps.
                       DESC

  s.homepage         = 'https://github.com/SteveBarnegren/SBRunLoop'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'steve.barnegren@gmail.com' => 'steve.barnegren@gmail.com' }
  s.source           = { :git => 'https://github.com/SteveBarnegren/SBRunLoop.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/stevebarnegren'

  s.ios.deployment_target = '9.0'

  s.source_files = 'SBRunLoop/SBRunLoop/**/*.swift'

  s.frameworks = 'UIKit'
end
