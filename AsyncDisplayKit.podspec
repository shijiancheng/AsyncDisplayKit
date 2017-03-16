Pod::Spec.new do |spec|
  spec.name         = 'AsyncDisplayKit'
  spec.version      = '2.2-beta'
  spec.license      =  { :type => 'BSD' }
  spec.homepage     = 'http://asyncdisplaykit.org'
  spec.authors      = { 'Scott Goodson' => 'scottgoodson@gmail.com' }
  spec.summary      = 'Smooth asynchronous user interfaces for iOS apps.'
  spec.source       = { :git => 'https://github.com/shijiancheng/AsyncDisplayKit.git'}

  spec.documentation_url = 'http://asyncdisplaykit.org/appledoc/'

  spec.weak_frameworks = 'Photos','MapKit','AssetsLibrary'
  spec.requires_arc = true

  spec.ios.deployment_target = '8.0'

  # Uncomment when fixed: issues with tvOS build for release 2.0
  # spec.tvos.deployment_target = '9.0'

  # Subspecs
  spec.subspec 'Core' do |core|
    core.prefix_header_file = 'Source/AsyncDisplayKit-Prefix.pch'
    core.public_header_files = [
        'Source/*.h',
        'Source/Details/**/*.h',
        'Source/Layout/**/*.h',
        'Source/Base/*.h',
        'Source/Debug/AsyncDisplayKit+Debug.h',
        'Source/TextKit/ASTextNodeTypes.h',
        'Source/TextKit/ASTextKitComponents.h'
    ]
    
    core.source_files = [
        'Source/**/*.{h,m,mm}',
        'Base/*.{h,m}',
      
        # Most TextKit components are not public because the C++ content
        # in the headers will cause build errors when using
        # `use_frameworks!` on 0.39.0 & Swift 2.1.
        # See https://github.com/facebook/AsyncDisplayKit/issues/1153
        'Source/TextKit/*.h',
    ]
    core.xcconfig = { 'GCC_PRECOMPILE_PREFIX_HEADER' => 'YES' }
  end
  
  spec.subspec 'PINRemoteImage' do |pin|
      # Note: The core.prefix_header_file includes setup of PIN_REMOTE_IMAGE, so the line below could be removed.
      pin.xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) PIN_REMOTE_IMAGE=1' }
      pin.dependency 'PINRemoteImage/iOS', '= 3.0.0-beta.8'
      pin.dependency 'PINRemoteImage/PINCache'
      pin.dependency 'AsyncDisplayKit/Core'
  end

  spec.subspec 'IGListKit' do |igl|
      # Note: The core.prefix_header_file includes setup of IG_LIST_KIT, so the line below could be removed.
      igl.xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) IG_LIST_KIT=1' }
      igl.dependency 'IGListKit', '2.1.0'
      igl.dependency 'AsyncDisplayKit/Core'
  end
  
  spec.subspec 'Yoga' do |yoga|
      yoga.xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) YOGA=1' }
      yoga.dependency 'Yoga', '1.0.2'
      yoga.dependency 'AsyncDisplayKit/Core'
  end

  # Include optional PINRemoteImage module
  spec.default_subspec = 'PINRemoteImage'

  spec.social_media_url = 'https://twitter.com/AsyncDisplayKit'
  spec.library = 'c++'
  spec.pod_target_xcconfig = {
       'CLANG_CXX_LANGUAGE_STANDARD' => 'c++11',
       'CLANG_CXX_LIBRARY' => 'libc++'
  }

end
