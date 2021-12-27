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
    
    @ObservedObject var locationDelegate: LocationDelegate = LocationDelegate()
    let locationManager = CLLocationManager()
    
    @State var statusString: String = "Starting up..."
    @State var pauseButtonText: String = "Pause"
    @State var paused: Bool = false
    
    var currentVolume: Float = 0.5
    
    init() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = locationDelegate
        currentVolume = getCurrentVolume()
        
        locationManager.startUpdatingLocation()
    }
    
    var body: some View {
        Text(statusString).padding()
        Text("Min volume: \(locationDelegate.minVolume, specifier: "%.f")/16").padding()
        Slider(value: $locationDelegate.minVolume, in: 00...16, step: 1).padding()
        Text("Max volume: \(locationDelegate.maxVolume, specifier: "%.f")/16").padding()
        Slider(value: $locationDelegate.maxVolume, in: 00...16, step: 1).padding()
        Button(pauseButtonText, action: pause)
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
    
    func getCurrentVolume() -> Float {
        let volumeView = MPVolumeView()
        if let slider = volumeView.subviews.first as? UISlider
        {
            return slider.value
        }
        else {
            return 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
