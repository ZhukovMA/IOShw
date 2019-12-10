//
//  NetworkService.swift
//  Project_Weather
//
//  Created by Максим Жуков on 02/12/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import Foundation

class NetworkService {
    
    
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    
    
    
    static func getData(url: URL, location: String, completion:  @escaping ([String: [Any]]?) -> Void) {
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            var weatherArray : [String: [Any]] = ["current": [],
                                                  "hourly": [],
                                                  "daily": []
            ]
            
            if let data = data {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject],
                        let current = json["currently"] as? [String:AnyObject],
                        let daily = json["daily"] as? [String:AnyObject],
                        let dailyData = daily["data"] as? [[String:AnyObject]],
                        let hourly = json["hourly"] as? [String:AnyObject],
                        let hourlyData = hourly["data"] as? [[String:AnyObject]]
                        else {
                            completion([:])
                            return
                    }
                    
                    guard let currentWeatherObject = CurrentWeatherModel(json: current, location: location) else {
                        completion([:])
                        return
                    }
                    weatherArray["current"]?.append(currentWeatherObject)
                    
                    for data in hourlyData {
                        guard let hourlyWeatherObject = HourlyWeatherModel(json: data) else {
                            continue
                        }
                        weatherArray["hourly"]?.append(hourlyWeatherObject)
                    }
                    
                    for data in dailyData {
                        guard let dailyWeatherObject = DailyWeatherModel(json: data) else {
                            continue
                        }
                        weatherArray["daily"]?.append(dailyWeatherObject)
                    }
                    
                }catch {
                    print(error.localizedDescription)
                }
                completion(weatherArray)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}

