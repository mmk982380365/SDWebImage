Pod::Spec.new do |s|
  s.name = 'SDWebImage'
  s.version = '4.3.3'

  s.osx.deployment_target = '10.10'
  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.license = 'MIT'
  s.summary = 'Asynchronous image downloader with cache support with an UIImageView category.'
  s.homepage = 'https://github.com/rs/SDWebImage'
  s.author = { 'Olivier Poitrey' => 'rs@dailymotion.com' }
  s.source = { :git => 'https://github.com/rs/SDWebImage.git', :tag => s.version.to_s }

  s.description = 'This library provides a category for UIImageView with support for remote '      \
                  'images coming from the web. It provides an UIImageView category adding web '    \
                  'image and cache management to the Cocoa Touch framework, an asynchronous '      \
                  'image downloader, an asynchronous memory + disk image caching with automatic '  \
                  'cache expiration handling, a guarantee that the same URL won\'t be downloaded ' \
                  'several times, a guarantee that bogus URLs won\'t be retried again and again, ' \
                  'and performances!'

  s.requires_arc = true
  s.framework = 'ImageIO'
  s.module_map = 'WebImage/SDWebImage.modulemap'
  
  s.default_subspec = 'Core'

  s.subspec 'Core' do |core|
    core.source_files = 'SDWebImage/*.{h,m}', 'WebImage/SDWebImage.h'
    core.exclude_files = 'SDWebImage/MapKit/*.{h,m}', 'SDWebImage/WebP/*.{h,m}', 'SDWebImage/FLAnimatedImage/*.{h,m}'
  end

  s.subspec 'MapKit' do |mk|
    mk.osx.deployment_target = '10.10'
    mk.ios.deployment_target = '8.0'
    mk.tvos.deployment_target = '9.2'
    mk.source_files = 'SDWebImage/MapKit/*.{h,m}'
    mk.framework = 'MapKit'
    mk.dependency 'SDWebImage/Core'
  end

  s.subspec 'GIF' do |gif|
    gif.ios.deployment_target = '8.0'
    gif.source_files = 'SDWebImage/FLAnimatedImage/*.{h,m}'
    gif.dependency 'SDWebImage/Core'
    gif.dependency 'FLAnimatedImage', '~> 1.0'
    gif.xcconfig = {
      'USER_HEADER_SEARCH_PATHS' => '$(inherited) $(SRCROOT)/FLAnimatedImage/FLAnimatedImage'
    }
  end

  s.subspec 'WebP' do |webp|
    webp.source_files = 'SDWebImage/WebP/*.{h,m}'
    webp.xcconfig = { 
      'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) SD_WEBP=1',
      'USER_HEADER_SEARCH_PATHS' => '$(inherited) $(SRCROOT)/libwebp/src'
    }
    webp.watchos.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) SD_WEBP=1 WEBP_USE_INTRINSICS=1',
      'USER_HEADER_SEARCH_PATHS' => '$(inherited) $(SRCROOT)/libwebp/src'
    }
    webp.dependency 'SDWebImage/Core'
    webp.dependency 'libwebp', '~> 0.5'
  end
end
