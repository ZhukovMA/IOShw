//
//  APIManager.swift
//  Project_Weather
//
//  Created by Максим Жуков on 02/12/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import Foundation

class APIManager {
    private static let apiKey = "d21ade702c1e94d0b95f6f473e5cf40d"
    private static let baseUrl = "https://api.darksky.net/forecast"
    
    static func getPath(latitude: String, longitude: String) -> URL {
        let fullURL =  baseUrl + "/" + apiKey + "/" + latitude + "," + longitude
        guard var components = URLComponents(string: fullURL) else {
            return URL(string: baseUrl)!
        }
        let langItem = URLQueryItem(name: "lang", value: "ru")
        let unitsItem = URLQueryItem(name: "units", value: "si")
        
        components.queryItems = [langItem, unitsItem]
        
        return components.url!
    }
}
