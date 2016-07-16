Pod::Spec.new do |s|
  s.name             = 'UICarouselScrollView'
  s.version          = '0.9.0'
  s.summary          = 'Horizontal carousel scrollview with specific content size'
  s.homepage         = 'https://github.com/skswhwo/UICarouselScrollView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'skswhwo' => 'skswhwo@gmail.com' }
  s.source           = { :git => 'https://github.com/<GITHUB_USERNAME>/UICarouselScrollView.git', :tag => s.version.to_s }
  s.ios.deployment_target = '7.0'
  s.source_files = 'UICarouselScrollView/Classes/**/*'
end