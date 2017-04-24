//
//  FirstViewController.swift
//  Test1
//
//  Created by Vasiliy Vasilchenko on 4/19/17.
//  Copyright © 2017 Vasyl Vasylchenko. All rights reserved.
//

import UIKit
import SVProgressHUD

class SearchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var submitButton: UIButton!
    
    var categories : [Category]?
    var selectedRow = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton.isEnabled = false
        SVProgressHUD.show()
        ProductsManager.shared.requestCategories(completion: { [weak self] categories, error in
            SVProgressHUD.dismiss()
            if let categories = categories {
                self?.categories = categories
                self?.pickerView.reloadAllComponents()
            }
        })
    }

    @IBAction func submitPressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProductsViewController") as! ProductsViewController
        vc.keyword = textField.text ?? ""
        vc.categoryName = categories?[selectedRow].name ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK : Picker datasource && delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let categories = categories {
            return categories.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let category = categories?[row]
        return category?.name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
    }
    // MARK : TextField delegate

    @IBAction func textChangd(_ sender: Any) {
        submitButton.isEnabled = !(textField.text?.isEmpty)!
    }
    
}

