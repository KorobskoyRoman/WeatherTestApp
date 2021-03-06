//
//  GetCitiesWeather.swift
//  WeatherTestApp
//
//  Created by Roman Korobskoy on 30.12.2021.
//

import Foundation
import CoreLocation

let networkManager = NetworkManager()

func getCityWeather(citiesArray: [String], completionHandler: @escaping (Int, Weather) -> Void) {
    for (index, item) in citiesArray.enumerated() {
        
        getCoordinateFrom(city: item) { coordinate, error in
            guard let coordinate = coordinate, error == nil else { return }
            
            networkManager.fetchWeather(latitude: coordinate.latitude, longitude: coordinate.longitude) { weather in
                completionHandler(index, weather)
            }
        }
    }
}

//определяем координаты по названию города
func getCoordinateFrom(city: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> ()) {
    CLGeocoder().geocodeAddressString(city) { placemark, error in
        completion(placemark?.first?.location?.coordinate, error)
    }
}
