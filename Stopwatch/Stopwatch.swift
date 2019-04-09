//
//  Stopwatch.swift
//  Stopwatch
//
//  Created by Dan Coffman on 4/8/19.
//  Copyright © 2019 Dan Coffman. All rights reserved.
//

import Foundation

func noop() {}
func oneParamNoop<T>(value _: T) {}

class Stopwatch {
    private let interval: TimeInterval
    private var timer: Timer?
    var onStart: () -> Void = noop
    var onStop: () -> Void = noop
    var onTick: (Double) -> Void = oneParamNoop

    var elapsed: TimeInterval = 0 {
        didSet {
            onTick(elapsed)
        }
    }

    var isRunning = false {
        didSet {
            isRunning ? onStart() : onStop()
        }
    }

    init(interval: Double) {
        self.interval = interval
    }

    @objc func start() {
        timer = Timer(timeInterval: interval, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: RunLoop.Mode.common)
        isRunning = true
    }

    @objc func stop() {
        isRunning = false
        timer?.invalidate()
    }

    @objc func reset() {
        elapsed = 0
    }

    @objc func tick(timer _: Timer) {
        elapsed += interval
    }
}
