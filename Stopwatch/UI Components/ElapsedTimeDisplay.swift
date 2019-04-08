//
//  ElapsedTimeDisplay.swift
//  Stopwatch
//
//  Created by Dan Coffman on 4/8/19.
//  Copyright © 2019 Dan Coffman. All rights reserved.
//


import Foundation
import UIKit

class ElapsedTimeDisplay: UILabel {
    private static func getSubSeconds(elapsed: TimeInterval) -> String {
        let fractionalPart = elapsed.truncatingRemainder(dividingBy: 1)
        let displayString = String(format:"%.03f", fractionalPart)
        let start = displayString.index(displayString.startIndex, offsetBy: 2)
        let end = displayString.index(displayString.startIndex, offsetBy: 4)
        let range = start..<end
        return String(displayString[range])
    }
    
    private static func getElapsedString(elapsed: TimeInterval) -> String {
        let totalSeconds = Int(floor(elapsed))
        
        let minutes = (totalSeconds / 60) % 60
        let seconds = totalSeconds % 60
        let subSeconds = ElapsedTimeDisplay.getSubSeconds(elapsed: elapsed)
        
        return String(format:"%02d:%02d:%@", minutes, seconds, subSeconds)
    }
    
    var elapsed: Double = 0 {
        didSet {
            self.text = ElapsedTimeDisplay.getElapsedString(elapsed: elapsed)
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)

        self.textColor = Color.white
        self.shadowColor = .black
        self.shadowOffset = CGSize(width: 2, height: 2)
        self.font = UIFont(name: "AvenirNext-DemiBold", size: 72)!
        self.text = ElapsedTimeDisplay.getElapsedString(elapsed: elapsed)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
