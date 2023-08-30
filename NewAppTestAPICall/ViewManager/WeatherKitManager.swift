    //
    //  WeatherKitManager.swift
    //  NewAppTestAPICall
    //
    //  Created by Romain Poyard on 09/08/2023.
    //

    import Foundation
    import WeatherKit
    import CoreLocation
    import SwiftUI

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

extension WeatherKitManager {
    
    func symbolColor() -> Color {
        let symbolName = weather?.currentWeather.symbolName ?? "xmark"
        
        if symbolName.contains("sun") {
            return .yellow
        } else if symbolName.contains("cloud") {
            return .gray
        }else {
            return .black
        }
    }
    
    func backgroundImage() -> String {
        
        let tempSymbol = weather?.currentWeather.symbolName
        
        if let tempSymbol = tempSymbol {
        
            if tempSymbol.contains("sun") {
                return "backgroundBlueSky"
            } else {
                return "backgroundGraySky"
            }
            
        } else {
            
            return "backgroundGraySky"
            
        }
    }
}


