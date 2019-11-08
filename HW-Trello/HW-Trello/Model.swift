//
//  Model.swift
//  HW-Trello
//
//  Created by Максим Жуков on 06/11/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import Foundation

class Model: Codable {
    
        var title: String
        var items: [String]
        init(title: String, items: [String]) {
            self.title = title
            self.items = items
        }
    }

