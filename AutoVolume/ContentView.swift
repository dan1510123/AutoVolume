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
    
    init() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    var body: some View {
        Text("Hello, world!")
            .padding()
        Button("Update Volume", action: update)
    }
    
    func update() {
        locationManager.requestWhenInUseAuthorization()
        
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
