//
//  DataModel.swift
//  LawPavillionCodingTest
//
//  Created by Patrick Chikamso on 5/11/22.
//

import Foundation


struct DataModel: Codable {
    var items: [Item]
}

struct Item: Codable, Hashable {
    var login: String
    var avatar_url: String
    var type: String
}
