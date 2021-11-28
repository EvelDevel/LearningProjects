//
//  Petition.swift
//  07-WhitehousePetitions
//
//  Created by Евгений Никитин on 05.11.2021.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
