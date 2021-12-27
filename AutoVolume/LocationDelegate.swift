//
//  LocationDelegate.swift
//  AutoVolume
//
//  Created by Daniel Luo on 12/26/21.
//

import SwiftUI
import CoreLocation
import MediaPlayer

class LocationDelegate : NSObject, ObservableObject, CLLocationManagerDelegate {
    let volumeView = MPVolumeView()
    
    @Published var minVolume: Double = 0
    @Published var maxVolume: Double = 16
    
    override init() {
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let speed = manager.location?.speed else { return }
        print(speed)
        self.updateVolume(volume: minVolume / 16)
    }
    
    func updateVolume(volume: Double) {
        if let slider = self.volumeView.subviews.first as? UISlider
        {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
                slider.value = Float(volume)
            }
        }
    }
}
