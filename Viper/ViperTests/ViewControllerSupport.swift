//
//  PresenterSupport.swift
//  ViperTests
//
//  Created by Максим Жуков on 26/11/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import UIKit
@testable import Viper

class ViewControllerSupport: PresenterOutput {
     var clearCashCounter = 0
    var title = String()
    var text = String()
    func showImage(with image: UIImage?) {
        clearCashCounter += 1
    }
    
    func showAlertView(withTitle title: String, andText: String) {
        self.title = title
        text = andText
        clearCashCounter += 1
    }
}
