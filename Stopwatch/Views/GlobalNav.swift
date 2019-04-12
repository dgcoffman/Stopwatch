import Foundation
import UIKit

class GlobalNavBar: UITabBarController {
    convenience init() {
        let stopwatchView = StopwatchView()
        stopwatchView.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)

        let timerView = TimerView()
        timerView.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 2)

        self.init(views: [stopwatchView, timerView])

        delegate = self
    }

    init(views: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        setViewControllers(views, animated: true)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GlobalNavBar: UITabBarControllerDelegate {
    func tabBarController(_: UITabBarController,
                          animationControllerForTransitionFrom _: UIViewController,
                          to _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TabBarAnimatedTransitioning()
    }
}

final class TabBarAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let destination = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }

        destination.alpha = 0.0
        destination.transform = .init(scaleX: 1.5, y: 1.5)
        transitionContext.containerView.addSubview(destination)

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            destination.alpha = 1.0
            destination.transform = .identity
        }, completion: { transitionContext.completeTransition($0) })
    }

    func transitionDuration(using _: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
}
