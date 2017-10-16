//
//  NumpadWithDoneButton.swift
//  iSpend
//
//  Created by AJ Bond on 10/16/17.
//  Copyright © 2017 BondTwins. All rights reserved.
//

import UIKit

class NumpadWithDoneButton: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addDoneButtonOnKeyboard()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addDoneButtonOnKeyboard()
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
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc
    func doneButtonAction() {
        self.resignFirstResponder()
    }

}
