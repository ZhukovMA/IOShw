//
//  Object.swift
//  HW-Multithreading
//
//  Created by Максим Жуков on 13/11/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import Foundation

class Object {
    
    var collection: [Int] = []
    var index = 0
    
    let semaphore = DispatchSemaphore(value: 1)

    
    func write() {
        semaphore.wait()
        collection.append(index)
        print("добавлен \(index)")
        index += 1
        semaphore.signal()
    }
    
    func remove() {
        semaphore.wait()
        if !collection.isEmpty {
            let last = collection.last
            collection.removeLast()
            print("удален \(last!)")
        }
        semaphore.signal()
    }
    
    
}
