//
//  CitiesWeather+CoreDataProperties.swift
//  Clima
//
//  Created by Ivanov Viktor on 21.05.2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//
//

import Foundation
import CoreData


extension CitiesWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CitiesWeather> {
        return NSFetchRequest<CitiesWeather>(entityName: "CitiesWeather")
    }

    @NSManaged public var city: String?
    @NSManaged public var photo: Data?
}
