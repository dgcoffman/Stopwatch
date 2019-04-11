import UIKit

@UIApplicationMain
class EntryPoint: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication,
                     didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = HomeView()
        window!.makeKeyAndVisible()
        return true
    }
}
