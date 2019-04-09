# Podfile

platform :ios, '11.0'

use_frameworks!

def testing_pods
    pod 'Quick'
    pod 'Nimble'
end

target 'Stopwatch' do
    pod 'SnapKit', '~> 4.0.0'
end

target 'StopwatchTests' do
    testing_pods
end

target 'StopwatchUITests' do
    testing_pods
end
