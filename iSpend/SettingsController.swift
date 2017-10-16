//
//  SettingsController.swift
//  iSpend
//
//  Created by AJ Bond on 10/15/17.
//  Copyright © 2017 BondTwins. All rights reserved.
//

import UIKit

class SettingsController: UITableViewController {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var spendingLimitField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spendingLimitField.delegate = self
        spendingLimitField.text = String(Settings.sharedInstance.spendingLimit)
        saveButton.isEnabled = textFieldsAreValid()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveSettings() {
        if let slt = spendingLimitField.text,
            let sl = Double(slt) {
            Settings.sharedInstance.spendingLimit = sl
        }
    }
    
    func textFieldsAreValid() -> Bool {
        return !spendingLimitField.text!.isEmpty
    }
    
    @IBAction func save(_ sender: Any) {
        dismiss(animated: true, completion: saveSettings)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension SettingsController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        saveButton.isEnabled = textFieldsAreValid()
    }
    
}
