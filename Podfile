# Podfile

platform :ios, '11.0'

use_frameworks!
inhibit_all_warnings!

def testing_pods
    pod 'Quick'
    pod 'Nimble'
end

pod 'SwiftFormat/CLI'
pod 'xcbeautify'

target 'Stopwatch' do
    pod 'SnapKit', '~> 4.0.0'
end

target 'Tests' do
    testing_pods
end

target 'UITests' do
    testing_pods
end
