//
//  Constants.swift
//  weywallet
//
//  Created by Adrian Corscadden on 2016-10-24.
//  Copyright © 2016 weywallet LLC. All rights reserved.
//

import UIKit

let π: CGFloat = .pi

struct Padding {
    subscript(multiplier: Int) -> CGFloat {
        get {
            return CGFloat(multiplier) * 8.0
        }
    }
}

struct C {
    static let padding = Padding()
    struct Sizes {
        static let buttonHeight: CGFloat = 48.0
        static let headerHeight: CGFloat = 48.0
        static let largeHeaderHeight: CGFloat = 220.0
        static let logoAspectRatio: CGFloat = 125.0/417.0
    }
    
    static var defaultTintColor: UIColor = {
        return UIView().tintColor
    }()
    
    static let animationDuration: TimeInterval = 0.3
    static let secondsInDay: TimeInterval = 86400
    static let maxMoney: UInt64 = 256000000*100000000
    static let satoshis: UInt64 = 100000000
    static let walletQueue = "com.weywallet.walletqueue"
    static let btcCurrencyCode = "WAE"
    static let null = "(null)"
    static let maxMemoLength = 250
    static let feedbackEmail = "contact@weycoin.org"
    static let reviewLink = "n/a"
    static var standardPort: Int {
        return 11526
    }
}
