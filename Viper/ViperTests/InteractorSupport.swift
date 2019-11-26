//
//  InteractorSupport.swift
//  ViperTests
//
//  Created by Максим Жуков on 26/11/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import UIKit
@testable import Viper

class InteractorSupport: InteractorInput {
    var cash: Data?
    
    var clearCashCounter = 0

    func downloadImage() {
        return
    }
    
    func clearCash() {
        clearCashCounter += 1
        return
    }
    
    
    
}
