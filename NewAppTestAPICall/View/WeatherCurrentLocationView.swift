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
    @State var cityName: String = "Loading..."
    @State var tempIsHiden = false
    var body: some View {
        
        if locationManager.authorizationStatus == .authorizedWhenInUse {
           
                
                
            NavigationStack {
                ZStack {
                    Image(weathKitManager.backgroundImage())
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        
                    VStack(spacing: 30) {
                        
                        Text(cityName)
                            .font(.system(size: 40))
                            .multilineTextAlignment(.leading)
                            .lineLimit(0)
                        
                        Image(systemName: weathKitManager.symbol + ".fill")
                            .font(.system(size: 180))
                            .foregroundColor(weathKitManager.symbolColor())
                        
                        Text(weathKitManager.temp)
                            .font(.system(size: 35))
                            .foregroundColor(tempIsHiden ? .clear : .black)
                            
                           
                            
                    }
                    .fontDesign(.rounded)
                    .bold()
                    
                    .task {
                        await weathKitManager.getWeather(latitude: locationManager.latitude, longitude: locationManager.longitude)
                        withAnimation {
                            locationManager.lookUpCurrentLocation(completionHandler: { placemarks in
                                cityName = placemarks?.locality ?? "No city name found"
                           })
                        }
                         
                    }
                }
                .alert(locationManager.alertMessage, isPresented: $locationManager.isAlertOn, actions: {
                    Button("OK", action: { })
                })
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                                Button {
                                    withAnimation {
                                        cityName = "Loading..."
                                        tempIsHiden = true
                                    }
                                    
                                    Task {
                                        await weathKitManager.getWeather(latitude: locationManager.latitude, longitude: locationManager.longitude)
                                        withAnimation {
                                            locationManager.lookUpCurrentLocation(completionHandler: { placemarks in
                                                cityName = placemarks?.locality ?? "No city name found"
                                            })
                                            
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            withAnimation {
                                                tempIsHiden = false
                                            }
                                        }
                                    }
                                }label: {
                                    Image(systemName: "arrow.counterclockwise")
                                        .padding(5)
                                        .padding(.bottom, 2)
                                        .background(
                                        Circle()
                                            .foregroundColor(.white)
                                        )
                                }
                        
                            }
                    
                        }
                
                
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
