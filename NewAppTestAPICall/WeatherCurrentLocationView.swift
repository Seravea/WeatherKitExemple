//
//  WeatherCurrentLocationView.swift
//  NewAppTestAPICall
//
//  Created by Romain Poyard on 09/08/2023.
//

import SwiftUI

struct WeatherCurrentLocationView: View {
    
    @ObservedObject var weathKitManager = WeatherKitManager()
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            
            
            VStack(spacing: 30) {
                Text("weathKitManager.date")
                    .background(.yellow)
                
                Image(systemName: weathKitManager.symbol)
                    .font(.system(size: 200))
                
                Text(weathKitManager.temp)
                    .font(.system(size: 100))
                    .bold()
                    .fontDesign(.rounded)
                
                
            }
            .task {
                await weathKitManager.getWeather()
            }
            
        }
        
    }
}

struct WeatherCurrentLocationView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherCurrentLocationView()
    }
}
