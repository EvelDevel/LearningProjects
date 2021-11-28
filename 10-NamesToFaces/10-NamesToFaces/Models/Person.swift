//
//  Person.swift
//  10-NamesToFaces
//
//  Created by Евгений Никитин on 28.11.2021.
//

import UIKit

class Person: NSObject {

    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
