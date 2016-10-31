//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Shengkun Wei on 10/30/16.
//  Copyright © 2016 Shengkun Wei. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {
    
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.created = NSDate()
    }
}
