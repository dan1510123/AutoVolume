//
//  LocationDelegate.swift
//  AutoVolume
//
//  Created by Daniel Luo on 12/26/21.
//

import Foundation
import CoreLocation

class LocationDelegate : NSObject, CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let speed = manager.location?.speed else { return }
        print(speed)
    }
}
