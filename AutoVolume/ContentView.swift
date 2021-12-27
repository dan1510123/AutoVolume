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
    
    let locationManager = CLLocationManager()
    let locationDelegate = LocationDelegate()
    
    @State var statusString: String = "Starting up..."
    @State var pauseButtonText: String = "Pause"
    @State var paused: Bool = false
    
    @State var minVolume: Double = 0
    @State var maxVolume: Double = 0
    
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
        Text("Min volume: \(minVolume, specifier: "%.f")/16").padding()
        Slider(value: $minVolume, in: 00...16, step: 1).padding()
        Text("Max volume: \(maxVolume, specifier: "%.f")/16").padding()
        Slider(value: $maxVolume, in: 00...16, step: 1).padding()
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
    
    func updateVolume(volume: Float) {
        let volumeView = MPVolumeView()
        if let slider = volumeView.subviews.first as? UISlider
        {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
                slider.value = volume
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
