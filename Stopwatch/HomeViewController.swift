//
//  ViewController.swift
//  Stopwatch
//
//  Created by Dan Coffman on 4/7/19.
//  Copyright © 2019 Dan Coffman. All rights reserved.
//

import SnapKit
import UIKit

let defaultTimeInterval = 0.001

class HomeViewController: UIViewController {
    private let stopwatch: Stopwatch
    let lapTableViewController: LapTableViewController
    private let elapsedLabel = ElapsedTimeDisplay()

    private let startStopButton: Button = {
        let button = Button(text: "Start")
        button.addTarget(self, action: #selector(startStopwatch), for: .touchUpInside)
        return button
    }()

    private let resetButton: Button = {
        let button = Button(text: "Reset")
        button.addTarget(self, action: #selector(reset), for: .touchUpInside)
        return button
    }()

    private let lapButton: Button = {
        let button = Button(text: "Lap")
        button.addTarget(self, action: #selector(recordLapTime), for: .touchUpInside)
        return button
    }()

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(interval: Double = defaultTimeInterval) {
        let stopwatch = Stopwatch(interval: interval)
        self.init(stopwatch: stopwatch)
    }

    init(stopwatch: Stopwatch, lapTableViewController: LapTableViewController = LapTableViewController()) {
        self.stopwatch = stopwatch
        self.lapTableViewController = lapTableViewController
        super.init(nibName: nil, bundle: nil) // this sucks

        stopwatch.onStart = handleStart
        stopwatch.onStop = handleStop
        stopwatch.onTick = handleTick
    }

    private func replaceButtonTarget(withAction action: Selector) {
        startStopButton.removeTarget(nil, action: nil, for: .allEvents)
        startStopButton.addTarget(self, action: action, for: .touchUpInside)
    }

    private func handleStart() {
        replaceButtonTarget(withAction: #selector(stopStopwatch))
        startStopButton.setTitle("Stop", for: .normal)
    }

    private func handleStop() {
        replaceButtonTarget(withAction: #selector(startStopwatch))
        startStopButton.setTitle("Start", for: .normal)
    }

    private func handleTick(elapsed: TimeInterval) {
        elapsedLabel.elapsed = elapsed
    }

    @objc func startStopwatch() {
        stopwatch.start()
    }

    @objc func stopStopwatch() {
        stopwatch.stop()
    }

    @objc func reset() {
        stopwatch.reset()
        lapTableViewController.clear()
    }

    @objc func recordLapTime() {
        lapTableViewController.record(elapsed: stopwatch.elapsed)
    }

    private func initBackground() {
        let gradientStartColor = UIColor(
            red: CGFloat(10 / 255.0),
            green: CGFloat(80 / 255.0),
            blue: CGFloat(180 / 255.0),
            alpha: CGFloat(1.0)
        ).cgColor

        let gradientEndColor = gradientStartColor.copy(alpha: 0.6)

        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [gradientStartColor, gradientEndColor!]
        view.layer.insertSublayer(gradient, at: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initBackground()

        let buttonSpacer = UIView()

        let buttonContainer = UIStackView(arrangedSubviews: [resetButton, lapButton, startStopButton])
        buttonContainer.axis = .horizontal
        buttonContainer.distribution = .fillProportionally
        buttonContainer.alignment = .bottom

        let layout = UIStackView(arrangedSubviews: [elapsedLabel, lapTableViewController.tableView, buttonContainer])
        layout.translatesAutoresizingMaskIntoConstraints = false
        layout.axis = .vertical
        layout.distribution = .fillEqually
        layout.alignment = .center

        view.addSubview(layout)

        layout.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.centerX.equalTo(view.snp.centerX)
        }

        lapTableViewController.tableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(elapsedLabel.snp.bottom)
            make.bottom.equalTo(buttonContainer.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
        }

        buttonSpacer.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(24)
        }

        buttonContainer.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(view.safeAreaLayoutGuide.snp.width).offset(-48)
        }

        startStopButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(100)
        }

        resetButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(100)
        }
    }
}
