//
//  PurchaseTableViewController.swift
//  iSpend
//
//  Created by Oliver Duncan on 12/3/16.
//  Copyright © 2016 BondTwins. All rights reserved.
//

import UIKit

class EditPurchaseViewController: UITableViewController {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    
    let context = DataController.sharedInstance.persistentContainer.viewContext
    var purchase: Purchase?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let purchase = purchase {
            datePicker.date = Date(timeIntervalSinceReferenceDate: purchase.date)
            nameField.text = purchase.name
            amountField.text = String(purchase.amount)
        }
        toggleSaveButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

    @IBAction func cancel(_ sender: Any) {
        dismissViewController()
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
        dismissViewController()
    }
    
    @IBAction func validate(_ sender: UITextField) {
        toggleSaveButton()
    }
    
    func dismissViewController() {
        if self.presentingViewController != nil {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    func toggleSaveButton() {
        saveButton.isEnabled = (!nameField.text!.isEmpty && !amountField.text!.isEmpty)
    }
    
}