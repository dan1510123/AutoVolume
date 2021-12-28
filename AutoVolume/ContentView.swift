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
        UIApplication.shared.isIdleTimerDisabled = true
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
            Text("Max speed setting: \(vlHandler.maxSpeed) mph").padding()
            Slider(value: $vlHandler.maxSpeed, in: 00...100, step: 5).padding()
            Text(statusString).padding()
            Button(pauseButtonText, action: pause)
            Text("Current volume: \(vlHandler.currentVolume, specifier: "%.f")/16").padding()
            Button("Testing Mode", action: test)
        }
    }
    
    func test() {
        vlHandler.test()
    }
    
    func pause() {
        if(paused) {
            locationManager.startUpdatingLocation()
            statusString = "Running..."
            pauseButtonText = "Pause"
            paused = false
            UIApplication.shared.isIdleTimerDisabled = true
        }
        else {
            locationManager.stopUpdatingLocation()
            statusString = "Paused"
            pauseButtonText = "Start"
            paused = true
            UIApplication.shared.isIdleTimerDisabled = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
