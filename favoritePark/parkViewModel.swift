//
//  parkViewModel.swift
//  favoritePark
//
//  Created by Daniel on 3/17/25.
//
// VIEW DEMO: https://youtube.com/shorts/aM0fM5Kxd_k?feature=share

import Foundation
import MapKit

public class fruitViewModel:ObservableObject
{
 
    func groupNametoNum(gName:String)-> Int
    {
        let gMap: [String: Int] = ["A": 0, "B": 1, "C": 2, "D": 3, "E": 4, "F": 5, "G": 6, "H": 7, "I": 8, "J": 9, "K": 10, "L": 11, "M": 12, "N": 13, "O": 14, "P": 15, "Q": 16, "R": 17, "S": 18, "T": 19, "U": 20, "V": 21, "W": 22, "X": 23, "Y": 24, "Z": 25]
        return gMap[gName] ?? -1
    }
    
    @Published var FruitGroups = [
        FruitGroup(groupName: "A", fruits: [
            Fruit(name:"Meadow", image:"apple",
                latitude: 33.4255,
                longitude: -111.9400
                  , description: "Dogs allowed · Picnic tables · Playground", city: "Phoenix", parkImg: UIImage(named: "apple"))
        ]),
        FruitGroup(groupName: "B", fruits: [
            Fruit(name:"Wintler", image:"banana",
                latitude: 33.4255,
                longitude: -111.9400
            , description: "Dogs allowed · Picnic tables · Playground", city: "Tempe", parkImg: UIImage(named: "peach"))
        ]),
        FruitGroup(groupName: "C", fruits: [
            Fruit(name:"Cantaloupe", image:"apple",
                latitude: 33.4255,
                longitude: -111.9400
            , description: "Dogs allowed · Picnic tables · Playground", city: "Phoenix", parkImg: UIImage(named: "banana")),
            Fruit(name:"Cantaloupe",image:"peach",
                latitude: 33.4255,
                longitude: -111.9400
            , description: "Dogs allowed · Picnic tables · Playground", city: "Phoenix", parkImg: UIImage(named: "apple")),
            Fruit(name:"Cherry", image:"peach",
                latitude: 33.4255,
                longitude: -111.9400
            , description: "Dogs allowed · Picnic tables · Playground", city: "Phoenix", parkImg: UIImage(named: "banana")),
            Fruit(name:"Clementine", image:"peach",
                latitude: 33.4255,
                longitude: -111.9400
            , description: "Dogs allowed · Picnic tables · Playground", city: "Phoenix", parkImg: UIImage(named: "peach")),
            Fruit(name:"Marshall",image:"peach",
                latitude: 33.4255,
                longitude: -111.9400
            , description: "Dogs allowed · Picnic tables · Playground", city: "Phoenix", parkImg: UIImage(named: "defaultImage")),
            Fruit(name:"Cranberry",image:"peach",
                latitude: 33.4255,
                longitude: -111.9400
            , description: "Dogs allowed · Picnic tables · Playground", city: "Phoenix", parkImg: UIImage(named: "defaultImage"))
        ]),
        FruitGroup(groupName: "D", fruits: [
            Fruit(name:"Meadow", image:"apple",
                latitude: 33.4255,
                longitude: -111.9400
            , description: "Dogs allowed · Picnic tables · Playground", city: "Phoenix", parkImg: UIImage(named: "defaultImage"))
        ]),
        FruitGroup(groupName: "E", fruits: []),
        
        FruitGroup(groupName: "F", fruits: [
            Fruit (name: "Fig", image:"peach",
                latitude: 33.4255,
                longitude: -111.9400
            , description: "Dogs allowed · Picnic tables · Playground", city: "Phoenix", parkImg: UIImage(named: "defaultImage"))]
        ),
        
        FruitGroup(groupName: "G", fruits: []
        ),
        
        FruitGroup(groupName: "H", fruits: []
        ),
        
        FruitGroup(groupName: "I", fruits: []
        ),
        
        FruitGroup(groupName: "J", fruits: []
        ),
        
        FruitGroup(groupName: "K", fruits: []
        ),
        FruitGroup(groupName: "L", fruits: []
        ),
        FruitGroup(groupName: "M", fruits: []
        ),
        FruitGroup(groupName: "N", fruits: []
        ),
        FruitGroup(groupName: "O", fruits: []
        ),
        FruitGroup(groupName: "P", fruits: [Fruit(name:"Peach",image:"peach",
            latitude: 33.4255,
            longitude: -111.9400
        , description: "Dogs allowed · Picnic tables · Playground", city: "Phoenix", parkImg: UIImage(named: "defaultImage"))]
        ),
        FruitGroup(groupName: "Q", fruits: []
        ),
        FruitGroup(groupName: "R", fruits: []
        ),
        FruitGroup(groupName: "S", fruits: []
        ),
        FruitGroup(groupName: "T", fruits: []
        ),
        FruitGroup(groupName: "U", fruits: []
        ),
        FruitGroup(groupName: "V", fruits: []
        ),
        FruitGroup(groupName: "W", fruits: []
        ),
        FruitGroup(groupName: "X", fruits: []
        ),
        FruitGroup(groupName: "Y", fruits: []
        ),
        FruitGroup(groupName: "X", fruits: []
        )
        
      ]
   
    
    
}
