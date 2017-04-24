//
//  ProductsViewController.swift
//  Test1
//
//  Created by Vasiliy Vasilchenko on 4/20/17.
//  Copyright © 2017 Vasyl Vasylchenko. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD

class ProductsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var categoryName = ""
    var keyword = ""
    let dataSource = ProductsDataSource()
    var refreshControl:UIRefreshControl!

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLayout()
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        dataSource.navigation = navigationController
        reloadData()
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        collectionView!.addSubview(refreshControl)

        
    }
    
    func reloadData() {
        SVProgressHUD.show()
        ProductsManager.shared.requestProductsByKeyword(keyword, categoryName: categoryName, completion: { [weak self] products, error in
            SVProgressHUD.dismiss()
            if (self?.refreshControl.isRefreshing)! {
                self?.refreshControl.endRefreshing()
            }

            if let products = products {
                self?.dataSource.products = products
                self?.collectionView.reloadData()
                
                if products.count == 0 {
                    self?.showNoProductsAlert()
                }
            }
        })
    }
    
    func setUpLayout() {
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = CGSize.init(width: view.frame.size.width/3, height: view.frame.size.width/3)
        flow.scrollDirection = .vertical
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 0
        collectionView.collectionViewLayout = flow;
    }
    
    func showNoProductsAlert() {
        let alert = UIAlertController.init(title: "Oops", message: "No listings were found, please try another keyword or change category", preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "OK", style: .default, handler: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
}
