platform :ios, '9.0'
inhibit_all_warnings!

target :'Demo' do
use_frameworks!

	pod 'SnapKit'
	pod 'RxSwift'
	pod 'RxCocoa'
	pod 'Realm'
    pod 'SwiftForms', '~> 1.8.1'
    pod 'SnapKit'
    pod 'RealmSwift'
    pod 'JXPhotoBrowser', '~> 0.4.1'
    pod 'SwipeCellKit'
    pod 'RAMAnimatedTabBarController'
    pod 'IQKeyboardManagerSwift', '~> 5.0.6'
    pod 'Material', '~> 2.12.18'
    pod 'ObjectMapper'
    pod 'SwiftyAttributes'
    pod 'Player', '~> 0.8.4'
    pod 'Kingfisher'

    
    post_install do |installer|
        installer.pods_project.targets.each do |target|
            if target.name == 'RxSwift'
                target.build_configurations.each do |config|
                    if config.name == 'Debug'
                        config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D', 'TRACE_RESOURCES']
                    end
                end
            end
        end
    end

end
