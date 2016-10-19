Pod::Spec.new do |s|
  s.name             = 'UICarouselScrollView'
  s.version          = '1.1.2'
  s.platform         = :ios, '7.0'
  s.summary          = 'Horizontal carousel scrollview with specific content size'
  s.homepage         = 'https://github.com/skswhwo/UICarouselScrollView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'skswhwo' => 'skswhwo@gmail.com' }
  s.source           = { :git => 'https://github.com/skswhwo/UICarouselScrollView.git', :tag => s.version.to_s }
  s.ios.deployment_target = '7.0'
  s.source_files     = 'UICarouselScrollView/Classes/**/*.{h,m}'
  s.resources        = 'UICarouselScrollView/Classes/**/*.{png,bundle,xib,nib}'
  s.requires_arc     = true
end
