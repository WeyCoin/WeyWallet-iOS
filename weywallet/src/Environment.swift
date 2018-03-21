//
//  Environment.swift
//  weywallet
//
//  Created by Adrian Corscadden on 2017-06-20.
//  Copyright © 2017 weywallet LLC. All rights reserved.
//

import UIKit

struct E {
    static let isTestnet: Bool = {
        return false
    }()
    static let isTestFlight: Bool = {
        return false
    }()
    static let isSimulator: Bool = {
        return false
    }()
    static let isDebug: Bool = {
        return false
    }()
    static let isScreenshots: Bool = {
        return false
    }()
    static var isIPhone4: Bool {
        return UIApplication.shared.keyWindow?.bounds.height == 480.0
    }
    static var isIPhone5: Bool {
        return (UIApplication.shared.keyWindow?.bounds.height == 568.0) && (E.is32Bit)
    }
    static let is32Bit: Bool = {
        return MemoryLayout<Int>.size == MemoryLayout<UInt32>.size
    }()
}
