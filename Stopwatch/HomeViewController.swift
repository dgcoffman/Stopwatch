//
//  ViewController.swift
//  Stopwatch
//
//  Created by Dan Coffman on 4/7/19.
//  Copyright © 2019 Dan Coffman. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    let start: Date
    let backgroundColor: UIColor
    var timer: Timer?
    var isStopped = false {
        didSet {
            stopButton.setTitle(isStopped ? "RESET" : "STOP", for: .normal)
        }
    }
    
    let startButton = UIButton(type: UIButton.ButtonType.system)
    let stopButton = UIButton(type: UIButton.ButtonType.system)
    let elapsedLabel =  UILabel()
    
    var elapsed: Double = 0 {
        didSet {
            self.elapsedLabel.text = String(format:"%f", elapsed);
        }
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroudColor: UIColor) {
        self.backgroundColor = backgroudColor
        self.start = Date();
        
        // https://stackoverflow.com/questions/30679129/how-to-write-init-methods-of-a-uiviewcontroller-in-swift
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = self.backgroundColor
        
        startButton.frame = CGRect(x: 100, y: 0, width: 300, height: 120)
        startButton.setTitle("START", for: .normal)
        startButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        
        stopButton.frame = CGRect(x: 100, y: 100, width: 300, height: 120)
        stopButton.setTitle("STOP", for: .normal)
        
        elapsedLabel.frame = CGRect(x: 100, y: 200, width: 300, height: 120)
        
        view.addSubview(startButton)
        view.addSubview(stopButton)
        view.addSubview(elapsedLabel)
    }
    
    @objc func startTimer() {
        self.timer = Timer(timeInterval: 0.01, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        RunLoop.current.add(timer as! Timer, forMode: RunLoop.Mode.common)
        stopButton.addTarget(self, action: #selector(stopTimer), for: .touchUpInside)
    }
    
    @objc func stopTimer() {
        guard let timer = timer else { return }
        self.isStopped = true
        self.elapsed = timer.fireDate.timeIntervalSince(self.start)
        timer.invalidate()
        stopButton.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
    }
    
    @objc func resetTimer() {
        self.isStopped = false;
        self.elapsed = 0;
        stopButton.addTarget(self, action: #selector(stopTimer), for: .touchUpInside)
    }
    
    // @objc instructs Swift to make this method available to Objective-C
    @objc func fireTimer(timer: Timer) {
        self.elapsed = timer.fireDate.timeIntervalSince(self.start)
    }
}
