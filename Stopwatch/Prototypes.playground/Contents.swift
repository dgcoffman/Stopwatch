//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        //label.frame = CGRect(width: 400, height: 100)
        label.text = "Hello World!"
        label.textColor = .black
        // label.adjustsFontSizeToFitWidth = true
        
        
        let shadowColor = UIColor( red: CGFloat(10/255.0), green: CGFloat(80/255.0), blue: CGFloat(180/255.0), alpha: CGFloat(1.0) )

        label.shadowColor = shadowColor
        label.shadowOffset = CGSize(width: 2, height: 2)
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 32)!
        
        label.center.x = view.center.x
        label.center.y = view.center.y
        
        view.addSubview(label)
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
