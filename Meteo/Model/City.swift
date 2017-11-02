//
//  City.swift
//  Meteo
//
//  Created by Leo Marcotte on 24/10/2017.
//  Copyright © 2017 Leo Marcotte. All rights reserved.
//

import RealmSwift

class City: Object {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var longitude: Double = 0
    @objc dynamic var latitude: Double = 0

    @objc dynamic var temperature: Double = 0
    @objc dynamic var humidity: Double = 0
    @objc dynamic var pressure: Double = 0
    
    @objc dynamic var sunrise = Date()
    @objc dynamic var sunset = Date()
    
    var celsius: Double {
        return temperature - 273.15
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

