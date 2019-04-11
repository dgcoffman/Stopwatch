import Foundation
import UIKit

class GlobalNavBar: UITabBarController {
    convenience init() {
        let stopwatchView = StopwatchView()
        stopwatchView.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)

        let timerView = TimerView()
        timerView.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 2)

        self.init(views: [stopwatchView, timerView])
    }

    init(views: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        setViewControllers(views, animated: true)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
