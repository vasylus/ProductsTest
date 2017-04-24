//
//  DetailProductViewController.swift
//  Test1
//
//  Created by Vasiliy Vasilchenko on 4/21/17.
//  Copyright © 2017 Vasyl Vasylchenko. All rights reserved.
//

import UIKit

class DetailProductViewController: UIViewController {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var isSavedMode = false
    var productImage: UIImage!
    var product: Product!
    var storedProduct : ProductEntity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let urlStr = product.photo.url {
            productImageView.sd_setImage(with: URL.init(string: urlStr))
        }
        topLabel.text = product.name + "\nPrice: " + product.price + " " + product.currencyCode
        descriptionLabel.text = product.description
        saveButton.isHidden = isSavedMode
        deleteButton.isHidden = !saveButton.isHidden
        
    }
    
    @IBAction func save(_ sender: Any) {
        DataStore.sharedInstance.saveProduct(product)

    }
    
    @IBAction func deleteProduct(_ sender: Any) {
        DataStore.sharedInstance.deleteProduct(storedProduct)
        navigationController?.popViewController(animated: true)
    }

}
