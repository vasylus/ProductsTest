//
//  Category.swift
//  Test1
//
//  Created by Vasiliy Vasilchenko on 4/19/17.
//  Copyright © 2017 Vasyl Vasylchenko. All rights reserved.
//

import ObjectMapper

struct Category: Mappable {
    
    var categoryId: Int!
    var name: String!
    var metaTitle: String!
    var metaKeywords: String!
    var metaDescription: String!
    var pageDescription: String!
    var pageTitle: String!
    var categoryName: String!
    var shortName: String!
    var categryoLongName: String!
    var childrensCount: Int!
    
    mutating func mapping(map: Map) {
        
         categoryId         <- map["category_id"]
         name               <- map["name"]
         metaTitle          <- map["meta_title"]
         metaKeywords       <- map["meta_keywords"]
         metaDescription    <- map["meta_description"]
         pageDescription    <- map["page_description"]
         pageTitle          <- map["page_title"]
         categoryName       <- map["category_name"]
         shortName          <- map["short_name"]
         categryoLongName   <- map["long_name"]
         childrensCount     <- map["num_children"]

    }
    
    init?(map: Map) {
        
    }
    
    init() {
        
    }

}
