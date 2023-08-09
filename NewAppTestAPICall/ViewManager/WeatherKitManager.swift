    //
    //  WeatherKitManager.swift
    //  NewAppTestAPICall
    //
    //  Created by Romain Poyard on 09/08/2023.
    //

    import Foundation
    import WeatherKit
    import CoreLocation

   @MainActor class WeatherKitManager: ObservableObject {
        @Published var weather: Weather?
        var symbol: String {
            weather?.currentWeather.symbolName ?? "xmark"
        }
        
        var temp: String {
            let temp = weather?.currentWeather.temperature
            let convertTemp = temp?.converted(to: .celsius).description
            
            return convertTemp ?? "Loading weather data..."
        }
       
       var date: String {
           let dateFormater = DateFormatter()
           let date: Date = Date()
           return dateFormater.string(from: date)
           
       }
        
        @Published var errorMessage: String?
        
    }


    extension WeatherKitManager {
        
        
        func getWeather(latitude: Double, longitude: Double) async {
                do {
                    weather = try await Task.detached(priority: .userInitiated) {
                        return try await WeatherService.shared.weather(for: .init(latitude: latitude, longitude: longitude))
                    }.value
                } catch {
                    fatalError("\(error)")
                }
            }
    }


