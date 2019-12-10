//
//  LocationManager.swift
//  Project_Weather
//
//  Created by Максим Жуков on 08/12/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import UIKit
import CoreLocation

protocol LocationManagerDelegate {
    func showAlertView(withTitle title:String, andText text: String)
    func setDataFromLocationManager(data: [String: [Any]])
}




class GeopositionManager: NSObject {
    var delegate: LocationManagerDelegate?
    var locationManager = CLLocationManager()
    var currentLocation:CLLocation!
    
    override init() {
        super.init()
        checkLocation()
    }
    
    
    private func checkLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            locationManager.startMonitoringSignificantLocationChanges()
        } else {
            
        }
    }
    
    
    private func chekAutorizationLocation() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            currentLocation = locationManager.location
            CLGeocoder().reverseGeocodeLocation(currentLocation) { (placemark, error) in
                if error != nil
                {
                    print (error!)
                }
                else
                {
                    if let place = placemark?[0]
                    {
                        if let localion = place.locality
                        {
                            let url = APIManager.getPath(latitude: String(self.currentLocation.coordinate.latitude), longitude: String(self.currentLocation.coordinate.longitude))
                            NetworkService.getData(url: url, location: localion, completion: { (results) in
                                guard var result = results else {return}
                                
                                var currentWeatherObject = result["current"]![0] as! CurrentWeatherModel
                                let favoritesArray = CoreDataManager.retrieveData()
                                let filteredArray = favoritesArray.filter( { (user: Weather) -> Bool in
                                    return user.locationName == currentWeatherObject.location
                                })
                                if !filteredArray.isEmpty {
                                    currentWeatherObject.isFavorite = true
                                    result["current"]![0] = currentWeatherObject
                                    DispatchQueue.main.async {
                                        self.delegate?.setDataFromLocationManager(data: result)
                                    }
                                } else {
                                    DispatchQueue.main.async {
                                        self.delegate?.setDataFromLocationManager(data: result)
                                    }
                                }
                                
                            })
                            
                            
                        }
                    }
                }
            }
            break
        case .denied:
            delegate?.showAlertView(withTitle: "Ошибка", andText: "Службы геолокации отключены")
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            delegate?.showAlertView(withTitle: "Ошибка", andText: "Приложение не авторизованно для служб геолокации")
            break
        case .authorizedAlways:
            break
        @unknown default:
            print(description)
            break
        }
    }
}

extension GeopositionManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager = manager
        chekAutorizationLocation()
    }
    
}
