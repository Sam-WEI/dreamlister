//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by WeiShengkun on 10/31/16.
//  Copyright © 2016 Shengkun Wei. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var tfDetails: UITextField!
    
    var stores = [Store]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        storePicker.dataSource = self
        storePicker.delegate = self
        
        getStores()
        
//        let store1 = Store(context: context)
//        store1.name = "Kearny Shoprite"
//        
//        let store2 = Store(context: context)
//        store2.name = "Amazon"
//        
//        let store3 = Store(context: context)
//        store3.name = "Bestbuy"
//        
//        let store4 = Store(context: context)
//        store4.name = "Lexus Dealership"
//        
//        let store5 = Store(context: context)
//        store5.name = "Steam"
//        
//        ad.saveContext()

    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func getStores() {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
        
        
    }
    

}
