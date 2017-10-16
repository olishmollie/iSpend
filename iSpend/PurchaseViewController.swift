//
//  PurchaseTableViewController.swift
//  iSpend
//
//  Created by Oliver Duncan on 12/3/16.
//  Copyright © 2016 BondTwins. All rights reserved.
//

import UIKit

class PurchaseViewController: UITableViewController {
    
    @IBOutlet weak var purchaseLabel: UILabel!
    @IBOutlet weak var purchasePrice: UILabel!
    
    let context = DataController.sharedInstance.persistentContainer.viewContext
    var purchase: Purchase?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let purchase = purchase {
            purchaseLabel.text = purchase.name
            purchasePrice.text = String(purchase.amount)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
