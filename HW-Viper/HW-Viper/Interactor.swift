//
//  Interactor.swift
//  HW-Viper
//
//  Created by Максим Жуков on 10/11/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import Foundation

protocol InteractorInput {
    func downloadImage()
}

class Interactor: InteractorInput {
    
    var output : InteractorOutput?
    
 
    func downloadImage() {
        getData { image, error in
            self.output?.setImage(data: image)
        }
    }
    
    func getData(completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string:"http://icons.iconarchive.com/icons/dtafalonso/ios8/512/Calendar-icon.png") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let currentError = error {
                completion(nil, currentError)
                return
            }
            
            guard let currentData = data else { return }
            completion(currentData, nil)
        }
        
        task.resume()
    }
}

protocol InteractorOutput {
    func setImage(data: Data?)
}
