//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by WeiShengkun on 10/31/16.
//  Copyright © 2016 Shengkun Wei. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var tfDetails: UITextField!
    @IBOutlet weak var ivThumb: UIImageView!
    
    var stores = [Store]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        storePicker.dataSource = self
        storePicker.delegate = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        getStores()
        
        if itemToEdit != nil {
            loadItemData()
        }
        
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
    
    
    @IBAction func savePressed(_ sender: UIButton) {
        var item: Item!
        if itemToEdit == nil {
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
        
        if let title = tfTitle.text, let price = Double(tfPrice.text!), let detail = tfDetails.text {
            item.title = title
            item.price = price
            item.details = detail
        }
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        
        let picture = Image(context: context)
        picture.image = ivThumb.image
        item.toImage = picture
        
        
        ad.saveContext()

        
        _ = navigationController?.popViewController(animated: true)
        
       
        
    }
    
    
    func loadItemData() {
        if let item = itemToEdit {
            tfTitle.text = item.title
            tfPrice.text = String(item.price)
            tfDetails.text = item.details
            
            ivThumb.image = item.toImage?.image as? UIImage
            
            if let store = item.toStore {
                for i in 0 ..< stores.count {
                    if stores[i].name == store.name {
                        storePicker.selectRow(i, inComponent: 0, animated: true)
                        break
                    }
                }
                
            }
        }
        
    }

    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
            
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addImagePressed(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            ivThumb.image = img
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    
}
