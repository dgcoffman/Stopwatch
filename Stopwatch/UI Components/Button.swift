//
//  Button.swift
//  Stopwatch
//
//  Created by Dan Coffman on 4/8/19.
//  Copyright © 2019 Dan Coffman. All rights reserved.
//

import Foundation
import UIKit

class Button: UIButton {
    let type = UIButton.ButtonType.system

    init(text: String) {
        super.init(frame: CGRect.zero)
        layer.cornerRadius = 4
        titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 24)!
        backgroundColor = Color.blue
        setTitle(text, for: .normal)
        setTitleColor(Color.white, for: .normal)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
