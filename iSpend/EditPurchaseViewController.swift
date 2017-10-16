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
        nameField.delegate = self
        amountField.delegate = self
        if let purchase = purchase {
            navigationItem.title = purchase.name
            datePicker.date = Date(timeIntervalSinceReferenceDate: purchase.date)
            nameField.text = purchase.name
            amountField.text = String(purchase.amount)
        }
        saveButton.isEnabled = textFieldsAreValid()
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
        
        if let purchase = purchase {
            set(purchase: purchase, name: name, amount: amount, date: date)
        } else {
            let newPurchase = Purchase(context: context)
            set(purchase: newPurchase, name: name, amount: amount, date: date)
        }
        DataController.sharedInstance.saveContext()
        dismissViewController()
    }
    
    func set(purchase: Purchase, name: String, amount: String, date: Date) {
        purchase.name = name
        purchase.amount = Double(amount)!
        purchase.date = date.timeIntervalSinceReferenceDate
    }
    
    func dismissViewController() {
        if self.presentingViewController != nil {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    func textFieldsAreValid() -> Bool {
        return !nameField.text!.isEmpty && !amountField.text!.isEmpty
    }
    
}

extension EditPurchaseViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textFieldsAreValid())
        saveButton.isEnabled = textFieldsAreValid()
    }
}
