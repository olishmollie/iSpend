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
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    
    let context = DataController.sharedInstance.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleSaveButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        let name = nameField.text!
        let amount = amountField.text!
        let date = datePicker.date
        let purchase = Purchase(context: context)
        purchase.name = name
        purchase.amount = Double(amount)!
        purchase.date = date.timeIntervalSinceReferenceDate
        DataController.sharedInstance.saveContext()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func validate(_ sender: UITextField) {
        toggleSaveButton()
    }
    
    func toggleSaveButton() {
        saveButton.isEnabled = (!nameField.text!.isEmpty && !amountField.text!.isEmpty)
    }
    
}
