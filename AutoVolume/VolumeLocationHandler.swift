//
//  VolumeLocationHandler.swift
//  AutoVolume
//
//  Created by Daniel Luo on 12/26/21.
//

import SwiftUI
import CoreLocation
import MediaPlayer

class VolumeLocationHandler : NSObject, ObservableObject, CLLocationManagerDelegate {
    let volumeView = MPVolumeView()
    
    @Published var minVolume: Double = 4
    @Published var maxVolume: Double = 16
    @Published var maxSpeed: Double = 80
    
    @Published var currentVolume: Double = 0
    
    override init() {
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let speed = manager.location?.speed else { return }
        
        if(shouldUpdateVolume(newSpeed: speed)) {
            let newVolume = calculateNewVolume(newSpeed: speed)
            self.updateVolume(volume: newVolume / 16)
            self.currentVolume = newVolume
        }
        else {
            self.currentVolume = getCurrentVolume()
        }
    }
    
    func shouldUpdateVolume(newSpeed: Double) -> Bool {
        print(newSpeed)
        return true
    }
    
    func calculateNewVolume(newSpeed: Double) -> Double {
        let mphSpeed: Double = newSpeed * 2.23694
        let newVolume: Double = minVolume + mphSpeed / maxSpeed * (maxVolume - minVolume)
        
        return newVolume
    }
    
    func getCurrentVolume() -> Double {
        if let slider = self.volumeView.subviews.first as? UISlider
        {
            return Double(slider.value * 16)
        }
        else {
            return 0
        }
    }
    
    func updateVolume(volume: Double) {
        if let slider = self.volumeView.subviews.first as? UISlider
        {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
                slider.value = Float(volume)
            }
        }
    }
    
    func test() {
        for i in 00...16 {
            let x = i
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(x) / 2) {
                self.updateVolume(volume: Double(i) / 16)
            }
        }
    }
}
