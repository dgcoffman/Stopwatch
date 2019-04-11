import Foundation
import UIKit

class TimerView: UIViewController {
    let color: UIColor

    init(backgroundColor: UIColor = UIColor.orange) {
        color = backgroundColor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view?.backgroundColor = color
    }
}
