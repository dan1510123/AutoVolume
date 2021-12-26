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
    
    var currentVolume: Float = 0.5
    
    init() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = locationDelegate
        currentVolume = getCurrentVolume()
        
        locationManager.startUpdatingLocation()
    }
    
    var body: some View {
        Text(statusString)
            .padding()
        Button("Pause usage", action: pause)
    }
    
    func pause() {
        locationManager.stopUpdatingLocation()
        statusString = "Paused"
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
