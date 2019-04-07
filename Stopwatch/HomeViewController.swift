//
//  ViewController.swift
//  Stopwatch
//
//  Created by Dan Coffman on 4/7/19.
//  Copyright © 2019 Dan Coffman. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    let start: Date;
    let backgroundColor: UIColor;
    var runCount = 0;
    var elapsed: Double = 0;
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroudColor: UIColor) {
        self.backgroundColor = backgroudColor
        self.start = Date();
        
        // https://stackoverflow.com/questions/30679129/how-to-write-init-methods-of-a-uiviewcontroller-in-swift
        super.init(nibName: nil, bundle: nil)
        
        let timer = Timer(timeInterval: 0.01, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = self.backgroundColor;
    }
    
    // @objc instructs Swift to make this method available to Objective-C
    @objc func fireTimer(timer: Timer) {
        self.elapsed = timer.fireDate.timeIntervalSince(self.start)
        print(elapsed)
        
        runCount += 1
        
        if runCount == 100 {
            timer.invalidate()
        }
    }
}
