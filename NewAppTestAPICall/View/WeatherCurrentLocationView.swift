//
//  WeatherCurrentLocationView.swift
//  NewAppTestAPICall
//
//  Created by Romain Poyard on 09/08/2023.
//

import SwiftUI

struct WeatherCurrentLocationView: View {
    
    @ObservedObject var weathKitManager = WeatherKitManager()
    @ObservedObject var locationManager = LocationDataManager()
    
    var body: some View {
        
        if locationManager.authorizationStatus == .authorizedWhenInUse {
           
                
                
            VStack(spacing: 30) {
                
                Text("weathKitManager.date")
                    .background(.yellow)
                
                Image(systemName: weathKitManager.symbol)
                    .font(.system(size: 200))
                
                Text(weathKitManager.temp)
                    .font(.system(size: 80))
                    .bold()
                    .fontDesign(.rounded)
                
            }
            
                
                
            
        }else {
           Text("We can't acces to your location")
                .task {
                    await weathKitManager.getWeather(latitude: locationManager.latitude, longitude: locationManager.longitude)
                }
        }
        
    }
}

struct WeatherCurrentLocationView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherCurrentLocationView()
    }
}
