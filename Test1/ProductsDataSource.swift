//
//  ProductsDataSource.swift
//  Test1
//
//  Created by Vasiliy Vasilchenko on 4/21/17.
//  Copyright © 2017 Vasyl Vasylchenko. All rights reserved.
//

import UIKit

class ProductsDataSource:NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var products : [Product]?
    var storedProducts : [ProductEntity]?

    var navigation : UINavigationController?
    var isSavedMode = false

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products?.count == nil ? 0 : (products?.count)!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let product = products?[indexPath.item]
        cell.nameLabel.text = product?.name
        if let urlStr = product?.photo.url {
            cell.imageView.sd_setImage(with: URL.init(string: urlStr))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
        if let product = products?[indexPath.item] {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "DetailProductViewController") as! DetailProductViewController
            vc.productImage = cell.imageView.image
            vc.product = product
            vc.isSavedMode = isSavedMode
            vc.storedProduct = storedProducts?[indexPath.item]
            navigation?.pushViewController(vc, animated: true)
        }
        
    }


}
