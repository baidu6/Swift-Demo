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
