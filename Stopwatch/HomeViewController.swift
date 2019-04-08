//
//  ViewController.swift
//  Stopwatch
//
//  Created by Dan Coffman on 4/7/19.
//  Copyright © 2019 Dan Coffman. All rights reserved.
//

import UIKit

let TIME_INTERVAL = 0.001

class HomeViewController: UIViewController {
    var timer: Timer?
    
    var isRunning = false {
        didSet {
            startStopButton.setTitle(isRunning ? "Stop" : "Start", for: .normal)
            startStopButton.removeTarget(nil, action: nil, for: .allEvents)
            startStopButton.addTarget(self, action: isRunning ? #selector(stopTimer) : #selector(startTimer), for: .touchUpInside)
        }
    }
    
    var elapsed: Double = 0 {
        didSet {
            self.elapsedLabel.text = getElapsedString()
        }
    }
    
    let startStopButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.frame = CGRect(x: 100, y: 0, width: 300, height: 120)
        button.setTitle("Start", for: .normal)
        button.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.frame = CGRect(x: 100, y: 200, width: 300, height: 120)
        button.setTitle("Reset", for: .normal)
        button.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
        return button
    }()
    
    let elapsedLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 100, y: 300, width: 300, height: 120));
        label.text = "0.00"
        return label;
    }()
    
    func getElapsedString() -> String {
        return String(format:"%.2f", elapsed)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(startStopButton)
        view.addSubview(resetButton)
        view.addSubview(elapsedLabel)
    }
    
    @objc func startTimer() {
        self.timer = Timer(timeInterval: TIME_INTERVAL, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        RunLoop.current.add(self.timer!, forMode: RunLoop.Mode.common)
        self.isRunning = true
    }
    
    @objc func stopTimer() {
        self.isRunning = false
        self.timer?.invalidate()
    }
    
    @objc func resetTimer() {
        self.elapsed = 0;
    }
    
    // @objc instructs Swift to make this method available to Objective-C
    @objc func fireTimer(timer: Timer) {
        self.elapsed += TIME_INTERVAL
    }
}
