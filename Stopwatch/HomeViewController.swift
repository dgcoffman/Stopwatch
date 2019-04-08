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
    
    let startStopButton: Button = {
        let button = Button(text: "Start")
        button.addTarget(self, action: #selector(startStopwatch), for: .touchUpInside)
        return button
    }()
    
    let resetButton: Button = {
        let button = Button(text: "Reset")
        button.addTarget(self, action: #selector(resetStopwatch), for: .touchUpInside)
        return button
    }()
    
    let elapsedLabel: UILabel = {
        let label = UILabel();
        
        label.textColor = Color.white
        label.shadowColor = .black
        label.shadowOffset = CGSize(width: 2, height: 2)
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 72)!
        
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
    
    func getSubSeconds(elapsed: TimeInterval) -> String {
        let fractionalPart = elapsed.truncatingRemainder(dividingBy: 1)
        let displayString = String(format:"%.03f", fractionalPart)
        let start = displayString.index(displayString.startIndex, offsetBy: 2)
        let end = displayString.index(displayString.startIndex, offsetBy: 4)
        let range = start..<end
        return String(displayString[range])
    }
    
    func getElapsedString(elapsed: TimeInterval) -> String {
        let totalSeconds = Int(floor(elapsed))
        
        let minutes = (totalSeconds / 60) % 60
        let seconds = totalSeconds % 60
        let subSeconds = getSubSeconds(elapsed: elapsed)
        
        return String(format:"%02d:%02d:%@", minutes, seconds, subSeconds)
    }
    
    func handleTick(elapsed: TimeInterval) {
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
        
        let gradientEndColor = gradientStartColor.copy(alpha: 0.6)
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [gradientStartColor, gradientEndColor!]
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBackground()
        
        elapsedLabel.text = getElapsedString(elapsed: 0)
        
        let buttonSpacer = UIView();
        
        let buttonContainer = UIStackView(arrangedSubviews: [resetButton, buttonSpacer, startStopButton])
        buttonContainer.axis = .horizontal
        buttonContainer.distribution = .fillProportionally
        buttonContainer.alignment = .bottom
        
        let layout = UIStackView(arrangedSubviews: [elapsedLabel, buttonContainer])
        layout.translatesAutoresizingMaskIntoConstraints = false
        layout.axis = .vertical
        layout.distribution = .fillEqually
        layout.alignment = .center
        
        view.addSubview(layout)
        
        NSLayoutConstraint.activate([
            layout.topAnchor.constraint(equalTo: view.topAnchor),
            layout.leftAnchor.constraint(equalTo: view.leftAnchor),
            layout.rightAnchor.constraint(equalTo: view.rightAnchor),
            layout.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            layout.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonSpacer.widthAnchor.constraint(equalToConstant: 24),
            buttonContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -48),
            startStopButton.heightAnchor.constraint(equalToConstant: 100),
            resetButton.heightAnchor.constraint(equalTo: startStopButton.heightAnchor),
        ])
    }
}
