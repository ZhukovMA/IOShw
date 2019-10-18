//
//  NavigationControllerDelegate.swift
//  swift_lesson1_2
//
//  Created by Максим Жуков on 18/10/2019.
//  Copyright © 2019 16817252. All rights reserved.
//

import UIKit

class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
            print(viewController.description)
    }
}
