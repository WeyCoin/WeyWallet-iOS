//
//  LoginTransitionDelegate.swift
//  weywallet
//
//  Created by Adrian Corscadden on 2017-02-07.
//  Copyright © 2017 weywallet LLC. All rights reserved.
//

import UIKit

class LoginTransitionDelegate : NSObject, UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissLoginAnimator()
    }
}
