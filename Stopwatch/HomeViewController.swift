//
//  ViewController.swift
//  Stopwatch
//
//  Created by Dan Coffman on 4/7/19.
//  Copyright © 2019 Dan Coffman. All rights reserved.
//

import UIKit

let DEFAULT_TIME_INTERVAL = 0.001

class HomeViewController: UIViewController {
    let stopwatch: Stopwatch;
    
    let startStopButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.frame = CGRect(x: 100, y: 0, width: 300, height: 120)
        button.setTitle("Start", for: .normal)
        button.addTarget(self, action: #selector(startStopwatch), for: .touchUpInside)
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.frame = CGRect(x: 100, y: 200, width: 300, height: 120)
        button.setTitle("Reset", for: .normal)
        button.addTarget(self, action: #selector(resetStopwatch), for: .touchUpInside)
        return button
    }()
    
    let elapsedLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 100, y: 300, width: 300, height: 120));
        let shadowColor = UIColor( red: CGFloat(10/255.0), green: CGFloat(80/255.0), blue: CGFloat(180/255.0), alpha: CGFloat(1.0) )
        
        label.shadowColor = shadowColor
        label.shadowOffset = CGSize(width: 2, height: 2)
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 64)!
        
        return label;
    }()
    
    // this 100% sucks
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(interval: Double = DEFAULT_TIME_INTERVAL) {
        let stopwatch = Stopwatch(interval: interval)
        self.init(stopwatch: stopwatch)
    }
    
    init(stopwatch: Stopwatch) {
        self.stopwatch = stopwatch
        super.init(nibName: nil, bundle: nil) // this sucks
        
        stopwatch.onStart = handleStart
        stopwatch.onStop = handleStop
        stopwatch.onTick = handleTick
    }
    
    func replaceButtonTarget(withAction action: Selector) {
        startStopButton.removeTarget(nil, action: nil, for: .allEvents)
        startStopButton.addTarget(self, action: action, for: .touchUpInside)
    }
    
    func handleStart() {
        replaceButtonTarget(withAction: #selector(stopStopwatch))
        startStopButton.setTitle("Stop", for: .normal)
    }
    
    func handleStop() {
        replaceButtonTarget(withAction: #selector(startStopwatch))
        startStopButton.setTitle("Start", for: .normal)
    }
    
    func getSubSeconds(elapsed: Double) -> String {
        let fractionalPart = elapsed.truncatingRemainder(dividingBy: 1)
        let displayString = String(format:"%.03f", fractionalPart)
        let start = displayString.index(displayString.startIndex, offsetBy: 2)
        let end = displayString.index(displayString.startIndex, offsetBy: 4)
        let range = start..<end
        return String(displayString[range])
    }
    
    func getElapsedString(elapsed: Double) -> String {
        let totalSeconds = Int(floor(elapsed))
        
        let minutes = (totalSeconds / 60) % 60
        let seconds = totalSeconds % 60
        let subSeconds = getSubSeconds(elapsed: elapsed)
        
        return String(format:"%02d:%02d:%@", minutes, seconds, subSeconds)
    }
    
    func handleTick(elapsed: Double) {
        elapsedLabel.text = getElapsedString(elapsed: elapsed)
    }
    
    @objc func startStopwatch() {
        stopwatch.start()
    }
    
    @objc func stopStopwatch() {
        stopwatch.stop()
    }
    
    @objc func resetStopwatch() {
        stopwatch.reset()
    }
    
    func initBackground() {
        let gradientStartColor = UIColor( red: CGFloat(10/255.0), green: CGFloat(80/255.0), blue: CGFloat(180/255.0), alpha: CGFloat(1.0) ).cgColor
        
        let gradientEndColor = gradientStartColor.copy(alpha: 0.9)
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [gradientStartColor, gradientEndColor!]
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBackground()
        
        elapsedLabel.center.x = view.center.x
        elapsedLabel.center.y = view.center.y
        elapsedLabel.text = getElapsedString(elapsed: 0)
        
        view.addSubview(startStopButton)
        view.addSubview(resetButton)
        view.addSubview(elapsedLabel)
    }
}
