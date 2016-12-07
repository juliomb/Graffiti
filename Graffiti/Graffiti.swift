//
//  Graffiti.swift
//  Graffiti
//
//  Created by Timple Soft on 29/11/16.
//  Copyright © 2016 TimpleSoft. All rights reserved.
//

import UIKit
import MapKit

class Graffiti: NSObject, NSCoding {
    
    let address : String
    let latitude : Double
    let longitude : Double
    var imageName : String

    init(address: String, latitude: Double, longitude: Double, imageName: String) {
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.imageName = imageName
    }
    
    // MARK: NSCoding
    required convenience init?(coder aDecoder: NSCoder) {
        let address = aDecoder.decodeObject(forKey:"address") as! String
        let latitude = aDecoder.decodeDouble(forKey: "latitude")
        let longitude = aDecoder.decodeDouble(forKey: "longitude")
        let imageName = aDecoder.decodeObject(forKey: "imageName") as! String
        self.init(address: address, latitude: latitude, longitude: longitude, imageName: imageName)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.address, forKey: "address")
        aCoder.encode(self.latitude, forKey: "latitude")
        aCoder.encode(self.longitude, forKey: "longitude")
        aCoder.encode(self.imageName, forKey: "imageName")
    }
    
}

extension Graffiti: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        get{
            return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
        }
    }
    
    var title: String? {
        get {
            return "Graffiti"
        }
    }
    
    var subtitle: String? {
        get {
            return self.address.replacingOccurrences(of: "\n", with: ". ")
        }
    }
    
}
