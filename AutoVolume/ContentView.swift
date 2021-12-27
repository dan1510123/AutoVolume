//
//  ContentView.swift
//  AutoVolume
//
//  Created by Daniel Luo on 12/25/21.
//

import SwiftUI
import MediaPlayer
import CoreLocation

struct ContentView: View {
    
    @ObservedObject var vlHandler: VolumeLocationHandler = VolumeLocationHandler()
    let locationManager = CLLocationManager()
    
    @State var statusString: String = "Running..."
    @State var pauseButtonText: String = "Pause"
    @State var paused: Bool = false
    
    init() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = vlHandler
        
        locationManager.startUpdatingLocation()
    }
    
    var body: some View {
        Text("Auto Volume").bold().padding()
        VStack {
            Text("Min volume: \(vlHandler.minVolume, specifier: "%.f")/16").padding()
            Slider(value: $vlHandler.minVolume, in: 00...16, step: 1).padding()
            Text("Max volume: \(vlHandler.maxVolume, specifier: "%.f")/16").padding()
            Slider(value: $vlHandler.maxVolume, in: 00...16, step: 1).padding()
            Text("Rate of increase: \(vlHandler.rateOfIncreaseNumerator)/ \(vlHandler.rateOfIncreaseDenominator)").padding()
            Slider(value: $vlHandler.rateOfIncreaseNumerator, in: 00...1000, step: 1).padding()
            Slider(value: $vlHandler.rateOfIncreaseDenominator, in: 1...1000, step: 1).padding()
            Text(statusString).padding()
            Button(pauseButtonText, action: pause)
            Text("Current volume: \(vlHandler.currentVolume, specifier: "%.f")/16").padding()
        }
    }
    
    func pause() {
        if(paused) {
            locationManager.startUpdatingLocation()
            statusString = "Running..."
            pauseButtonText = "Pause"
            paused = false
        }
        else {
            locationManager.stopUpdatingLocation()
            statusString = "Paused"
            pauseButtonText = "Start"
            paused = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
