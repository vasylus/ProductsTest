//
//  Product.swift
//  Test1
//
//  Created by Vasiliy Vasilchenko on 4/20/17.
//  Copyright © 2017 Vasyl Vasylchenko. All rights reserved.
//

import Foundation
import ObjectMapper

struct Product: Mappable {
    
    var productId: Int!
    var name: String!
    var photo: Image!
    var price: String!
    var currencyCode: String!
    var description: String!

    mutating func mapping(map: Map) {
        
        productId           <- map["listing_id"]
        name                <- map["title"]
        photo            <- map["MainImage"]
        price               <- map["price"]
        currencyCode        <- map["currency_code"]
        description         <- map["description"]
        
    }
    
    init?(map: Map) {
        
    }
    
    init() {
        
    }
    
}
