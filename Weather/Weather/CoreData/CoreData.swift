//
//  CoreData.swift
//  Project_Weather
//
//  Created by Максим Жуков on 09/12/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import UIKit
import CoreData


class CoreDataManager{
    
    
    
    init() {
        
    }
    
    static func fetchAsDictionary(data: Weather, completion:  @escaping ([String: [Any]]?) -> Void){
        //MARK: - CurrentWeather
        let currentEntity = data.current?.array as! [CurrentWeather]
        let currentWeatherObject = CurrentWeatherModel(isFavorite: currentEntity[0].isFavorite,
                                                       temperature: currentEntity[0].temperature,
                                                       summary: currentEntity[0].summary!,
                                                       location: currentEntity[0].location!,
                                                       pressure: currentEntity[0].pressure,
                                                       humidity: currentEntity[0].humidity,
                                                       icon: UIImage(data: currentEntity[0].icon!)!)
        
        
        
        
        //MARK: - HourlyWeather
        
        let hourlyEntity = data.hourly?.array as! [HourlyWeather]
        var hourlyWeatherObjects = [HourlyWeatherModel]()
        for item in hourlyEntity {
            hourlyWeatherObjects.append(HourlyWeatherModel(icon: UIImage(data: item.icon!)!,
                                                           time: item.time!,
                                                           temperature: item.temperature))
        }
        
        
        //MARK: - DailyWeather
        
        let dailyEntity = data.daily?.array as! [DailyWeather]
        var dailyWeatherObjects = [DailyWeatherModel]()
        for item in dailyEntity {
            dailyWeatherObjects.append(DailyWeatherModel(time: item.time!,
                                                         temperatureHigh: item.temperatureHight,
                                                         temperatureLow: item.temperatureLow,
                                                         icon: UIImage(data: item.icon!)!))
        }
        
        let weatherArray : [String: [Any]] = ["current": [currentWeatherObject],
                                              "hourly": hourlyWeatherObjects,
                                              "daily": dailyWeatherObjects ]
        completion(weatherArray)
    }
    
    
    static func saveAsEntity(data: [String: [Any]], completion:  @escaping ([Weather]?) -> Void){
        var weather: Weather!
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let currentWeatherObject = data["current"]![0] as! CurrentWeatherModel
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Weather> = Weather.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "locationName == %@", currentWeatherObject.location)
        do {
            var results = try context.fetch(fetchRequest)
            
            if results.isEmpty {
                
                weather = Weather(context: context)
                weather.locationName = currentWeatherObject.location
                //MARK: - CurrentWeather
                
                let currentEntity = CurrentWeather(context: context)
                currentEntity.humidity = currentWeatherObject.humidity
                currentEntity.isFavorite = currentWeatherObject.isFavorite
                currentEntity.location = currentWeatherObject.location
                currentEntity.summary = currentWeatherObject.summary
                currentEntity.pressure = currentWeatherObject.pressure
                currentEntity.temperature = currentWeatherObject.temperature
                
                let image = currentWeatherObject.icon
                let imageData = image.pngData()
                currentEntity.icon = imageData
                
                let current = weather.current?.mutableCopy() as? NSMutableOrderedSet
                current?.add(currentEntity)
                weather.current = current
                
                //MARK: - HourlyWeather
                
                let hourlyWeatherObject = data["hourly"] as! [HourlyWeatherModel]
                let hourly = weather.hourly?.mutableCopy() as? NSMutableOrderedSet
                for item in hourlyWeatherObject {
                    let hourlyEntity = HourlyWeather(context: context)
                    hourlyEntity.time = item.time
                    hourlyEntity.temperature = item.temperature
                    
                    let image = item.icon
                    let imageData = image.pngData()
                    hourlyEntity.icon = imageData
                    hourly?.add(hourlyEntity)
                }
                weather.hourly = hourly
                
                //MARK: - DailyWeather
                
                let dailyWeatherObject = data["daily"] as! [DailyWeatherModel]
                let daily = weather.daily?.mutableCopy() as? NSMutableOrderedSet
                for item in dailyWeatherObject {
                    let dailyEntity = DailyWeather(context: context)
                    dailyEntity.time = item.time
                    dailyEntity.temperatureHight = item.temperatureHigh
                    dailyEntity.temperatureLow = item.temperatureLow
                    
                    let image = item.icon
                    let imageData = image.pngData()
                    dailyEntity.icon = imageData
                    daily?.add(dailyEntity)
                }
                weather.daily = daily
                
                try context.save()
                let secondRequest: NSFetchRequest<Weather> = Weather.fetchRequest()
                results = try context.fetch(secondRequest)
                completion(results)
            } else {
                
            }
        } catch let error as NSError{
            print(error.userInfo)
        }
        
    }
    
    static func retrieveData() -> [Weather]{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let сontext =  appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Weather> = Weather.fetchRequest()
        do {
            let results = try сontext.fetch(fetchRequest)
            return results
        } catch {
            print("Failed")
            return []
        }
        
    }
    
    
    
    static func removeData(locationName: String, completion:  @escaping ([Weather]?) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Weather> = Weather.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "locationName == %@", locationName)
        do {
            var results = try context.fetch(fetchRequest)
            if !results.isEmpty {
                context.delete(results.first!)
            }
            try! context.save()
            let secondRequest: NSFetchRequest<Weather> = Weather.fetchRequest()
            results = try context.fetch(secondRequest)
            completion(results)
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    
}
