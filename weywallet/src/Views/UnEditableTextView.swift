//
//  UnEditableTextView.swift
//  weywallet
//
//  Created by Adrian Corscadden on 2017-04-04.
//  Copyright © 2017 weywallet LLC. All rights reserved.
//

import UIKit

class UnEditableTextView : UITextView {
    override var canBecomeFirstResponder: Bool {
        return false
    }
}
