//
//  ProductsManager.swift
//  Test1
//
//  Created by Vasiliy Vasilchenko on 4/19/17.
//  Copyright © 2017 Vasyl Vasylchenko. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class ProductsManager {
    
    static let shared: ProductsManager = {
        let instance = ProductsManager()
        return instance
    }()

    func requestCategories(completion :@escaping (_ categories:[Category]?, _ error : Error?)->()) {
        Alamofire.request("https://openapi.etsy.com/v2/taxonomy/categories?api_key=l6pdqjuf7hdf97h1yvzadfce", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { dataResponse in
            var categories = [Category]()
            if let json = dataResponse.value as? [String:Any] {
                if let tempArray = json["results"] as? [Any] {
                    for cat in tempArray {
                        
                        let category = Mapper<Category>().map(JSON: cat as! [String : Any])
                        
                        categories.append(category!)
                    }
                    completion(categories, nil)
                }
            }else {
                
            }
        })
    }
    
    func requestProductsByKeyword(_ keyword: String, categoryName: String, completion: @escaping (_ products:[Product]?, _ error : Error?)->()) {
        let url = "https://openapi.etsy.com/v2/listings/active?api_key=l6pdqjuf7hdf97h1yvzadfce&category=\(categoryName)&keywords=\(keyword)&includes=MainImage"
        
        Alamofire.request(url).responseJSON(completionHandler: { dataResponse in
            if let json = dataResponse.value as? [String: Any] {
                if let tempArray = json["results"] as? [Any] {
                    var products = [Product]()
                    
                    for product in tempArray {
                        
                        let product = Mapper<Product>().map(JSON: product as! [String : Any])
                        
                        products.append(product!)
                    }
                    completion(products, nil)
                }
            } else {
                
            }
        })
        
    }
    
}
