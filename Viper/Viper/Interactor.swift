//
//  Interactor.swift
//  HW-Viper
//
//  Created by Максим Жуков on 10/11/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

protocol InteractorInput {
    func downloadImage()
    func clearCash()
    var cash: Data? { get set }
}

extension URLSession: URLSessionProtocol {}


class Interactor: InteractorInput {
    
    var output : InteractorOutput?
    var urlSession: URLSessionProtocol = URLSession.shared
    var cash: Data?
    
    func downloadImage() {
        getData { image, error in
            self.cash = image
            self.output?.notifyAboutDownload(data: self.cash)
        }
    }
    
    func getData(completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string:"http://icons.iconarchive.com/icons/dtafalonso/ios8/512/Calendar-icon.png") else { return }
        let task = urlSession.dataTask(with: url) { data, response, error in
            if let currentError = error {
                completion(nil, currentError)
                return
            }
            guard let currentData = data else { return }
            completion(currentData, nil)
        }
        task.resume()
    }
    
    func clearCash() {
        self.cash = nil
        output?.notifyAboutClearCash()
    }
}

protocol InteractorOutput {
    func notifyAboutDownload(data: Data?)
    func notifyAboutClearCash()
}
