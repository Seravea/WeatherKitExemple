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
        
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
    }
}

struct WeatherCurrentLocationView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherCurrentLocationView()
    }
}
