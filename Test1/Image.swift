//
//  Image.swift
//  Test1
//
//  Created by Vasiliy Vasilchenko on 4/21/17.
//  Copyright © 2017 Vasyl Vasylchenko. All rights reserved.
//

import Foundation
import ObjectMapper

struct Image: Mappable {
    
    var url: String!
    
    mutating func mapping(map: Map) {
        url <- map["url_170x135"]

    }
    
    init?(map: Map) {
        
    }
    
    init() {
        
    }
    
}
