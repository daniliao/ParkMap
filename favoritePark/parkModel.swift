//
//  fruitModel.swift
//  fruitTableSectionsSwiftUI
//
//  Created by Daniel Liao on 2/19/23.
//
// VIEW DEMO: https://youtube.com/shorts/aM0fM5Kxd_k?feature=share

import Foundation
import MapKit
import PhotosUI

struct Fruit: Identifiable{
    var id = UUID()
    var name = String()
    var image = String()
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    var description: String
    var city: String
    var parkImg: UIImage?
}


struct FruitGroup: Identifiable {
    var id = UUID()
    var groupName : String
    var fruits : [Fruit]
}




