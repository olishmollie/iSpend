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
        addDoneButtonOnKeyboard()
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
        
        if let purchase = purchase {
            set(purchase: purchase, name: name, amount: amount, date: date)
        } else {
            let newPurchase = Purchase(context: context)
            set(purchase: newPurchase, name: name, amount: amount, date: date)
        }
        DataController.sharedInstance.saveContext()
        dismissViewController()
    }
    
    @IBAction func validate(_ sender: UITextField) {
        toggleSaveButton()
    }
    
    func set(purchase: Purchase, name: String, amount: String, date: Date) {
        purchase.name = name
        purchase.amount = Double(amount)!
        purchase.date = date.timeIntervalSinceReferenceDate
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.amountField.inputAccessoryView = doneToolbar
    }
    
    @objc
    func doneButtonAction() {
        self.amountField.resignFirstResponder()
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
