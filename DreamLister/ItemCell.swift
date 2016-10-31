//
//  ItemCell.swift
//  DreamLister
//
//  Created by Shengkun Wei on 10/30/16.
//  Copyright © 2016 Shengkun Wei. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var ivThumb: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblPrice: UILabel!

    func configureCell(item: Item) {
        lblTitle.text = item.title
        lblPrice.text = "$\(item.price)"
        lblDetail.text = item.details
    }
    
}
