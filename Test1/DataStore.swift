//
//  DataStore.swift
//  PrizesTest
//
//  Created by Vasiliy Vasilchenko on 4/19/17.
//  Copyright © 2017 Vasyl Vasylchenko. All rights reserved.
//

import Foundation
import CoreData

final class DataStore: NSObject {
    
    var storedProducts = [ProductEntity]()
    
    private var context = NSManagedObjectContext(
        concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
    
    static let sharedInstance: DataStore = {
        let instance = DataStore()
        return instance
    }()
    
    override init() {
        context = CoreDataManager.sharedInstance.managedObjectContext
    }
    
    func saveProduct(_ product: Product) {
        let entityDescription = NSEntityDescription.entity(forEntityName: "ProductEntity", in: context)
        let productToSave = ProductEntity(entity:entityDescription!, insertInto: context)
        
        productToSave.setValue(product.name, forKey: "name")
        productToSave.setValue(product.photo.url, forKey: "photoUrl")
        productToSave.setValue(product.currencyCode, forKey: "currencyCode")
        productToSave.setValue(product.description, forKey: "productDescription")
        productToSave.setValue(product.price, forKey: "price")
        productToSave.setValue(product.productId, forKey: "productId")
        
        do {
            try context.save()
        } catch {
            abort()
        }
    }
    
    func savedProducts() -> [Product]? {
        let entityDescription = NSEntityDescription.entity(forEntityName: "ProductEntity", in: context)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entityDescription
        do {
            let result = try context.fetch(fetchRequest)
            if result.count == 0 {
                return []
            } else {
                storedProducts = result as! [ProductEntity]
                return convertToProductModel()
            }
        } catch let error {
            print("Could not fetch \(error), \(error._userInfo)")
            return []
        }
        
    }
    
    func deleteProduct(_ product: ProductEntity) {
        do {
            context.delete(product)
            try context.save()
        } catch let error {
            print("Could not fetch \(error), \(error._userInfo)")
        }
        
    }
    
    // MARK : Helper methods
    
    func convertToProductModel() -> [Product] {
        var tempArr = [Product]()
        for prod in storedProducts {
            var product = Product()
            var image = Image()
            image.url = prod.photoUrl
            product.name = prod.name
            product.description = prod.productDescription
            product.photo = image
            product.productId = Int(prod.productId)
            product.price = prod.price
            product.currencyCode = prod.currencyCode
            tempArr.append(product)
        }
        return tempArr
    }
    
    
}
