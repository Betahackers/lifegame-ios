//
//  UIViewController+makeRoot.swift
//  lifegame
//
//  Created by Marek on 19/02/2017.
//  Copyright © 2017 Marek Pivovarnik. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func makeRootViewControllerWithTransitionDuration(_ duration: TimeInterval) {
        if let appDelegate = UIApplication.shared.delegate {
            if appDelegate.window != nil {
                appDelegate.window!!.rootViewController = self
                UIView.transition(with: appDelegate.window!!,
                                  duration: duration,
                                  options: .transitionCrossDissolve,
                                  animations: {
                                    appDelegate.window!!.rootViewController = self
                },
                                  completion: nil
                )
            }
        }
    }
    
}
