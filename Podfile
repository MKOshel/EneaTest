source 'https://github.com/CocoaPods/Specs.git'
workspace 'GithubRepos'
platform :ios, '8.0'
use_frameworks!

def common_pods

pod 'Alamofire', '~> 4.0'
pod 'RxSwift',   '~> 4.3.1'
pod 'RxCocoa',   '~> 4.3.1'
pod 'ReachabilitySwift'
pod 'AlamofireImage'
pod 'SwiftyJSON'

end

project = Xcodeproj::Project.open "Githubrepos.xcodeproj"
project.targets.each do |t|
target t.name do
common_pods
end
end
