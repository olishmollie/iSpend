//
//  PurchaseTableViewController.swift
//  iSpend
//
//  Created by Oliver Duncan on 12/3/16.
//  Copyright © 2016 BondTwins. All rights reserved.
//

import UIKit

class PurchaseTableViewController: UITableViewController {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}
