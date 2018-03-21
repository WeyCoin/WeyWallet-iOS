//
//  UIScreen+Additions.swift
//  weywallet
//
//  Created by Adrian Corscadden on 2017-09-28.
//  Copyright © 2017 weywallet LLC. All rights reserved.
//

import UIKit

extension UIScreen {
    var safeWidth: CGFloat {
        return min(bounds.width, bounds.height)
    }
}
