//: A UIKit based Playground for presenting user interface

import PlaygroundSupport
import UIKit

let blue = #colorLiteral(red: 0.0862745098, green: 0.3215686275, blue: 0.9411764706, alpha: 1)
let white = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

let shadowColor = UIColor(
    red: CGFloat(10 / 255.0),
    green: CGFloat(80 / 255.0),
    blue: CGFloat(180 / 255.0),
    alpha: CGFloat(1.0)
)

class MyViewController: UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 20, y: 200, width: 600, height: 100)
        label.text = "00:54:89"
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.shadowColor = shadowColor
        label.shadowOffset = CGSize(width: 2, height: 2)
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 64)!

        let button = UIButton(type: UIButton.ButtonType.roundedRect)
        button.frame = CGRect(x: 10, y: 20, width: 240, height: 100)
        button.setTitle("Start", for: .normal)
        button.layer.cornerRadius = 4
        button.backgroundColor = blue
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 24)!
        button.setTitleColor(white, for: .normal)

        view.addSubview(label)
        view.addSubview(button)
        self.view = view
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
