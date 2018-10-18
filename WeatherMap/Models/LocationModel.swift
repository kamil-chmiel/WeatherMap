//
//  Location.swift
//  WeatherMap
//
//  Created by Kamil Chmiel on 16.10.2018.
//  Copyright © 2018 kamilchmiel. All rights reserved.
//

import RealmSwift

class LocationModel: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
