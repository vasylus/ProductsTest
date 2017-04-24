//
//  SecondViewController.swift
//  Test1
//
//  Created by Vasiliy Vasilchenko on 4/19/17.
//  Copyright © 2017 Vasyl Vasylchenko. All rights reserved.
//

import UIKit

class SavedViewController: UIViewController {

    let dataSource = ProductsDataSource()

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLayout()
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        dataSource.navigation = navigationController
        dataSource.isSavedMode = true

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let array = DataStore.sharedInstance.savedProducts()
        dataSource.products = array
        dataSource.storedProducts = DataStore.sharedInstance.storedProducts
        collectionView.reloadData()

    }

    func setUpLayout() {
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = CGSize.init(width: view.frame.size.width/3, height: view.frame.size.width/3)
        flow.scrollDirection = .vertical
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 0
        collectionView.collectionViewLayout = flow;
    }


}

