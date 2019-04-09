# Podfile

platform :ios, '11.0'

use_frameworks!
inhibit_all_warnings!

def testing_pods
    pod 'Quick'
    pod 'Nimble'
end

pod 'SwiftFormat/CLI'

target 'Stopwatch' do
    pod 'SnapKit', '~> 4.0.0'
end

target 'StopwatchTests' do
    testing_pods
end

target 'UITests' do
    testing_pods
end
