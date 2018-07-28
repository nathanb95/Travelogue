//
//  NewEntryViewController.swift
//  Travelogue
//
//  Created by Nathaniel Banderas on 7/27/18.
//  Copyright © 2018 Nathaniel Banderas. All rights reserved.
//

import UIKit

class NewEntriesViewController: UIViewController {
    
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var trip: Trip?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleText.delegate = self
        descriptionText.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        titleText.resignFirstResponder()
        descriptionText.resignFirstResponder()
    }
    
    @IBAction func saveEntry(_ sender: Any) {
        let name = titleText.text ?? ""
        let desc = descriptionText.text ?? ""
        let date = Date()
        
        if let entry = Entry(name: name, desc: desc, rawDate: date) {
            trip?.addToRawEntries(entry)
            
            do {
                try entry.managedObjectContext?.save()
                
                self.navigationController?.popViewController(animated: true)
            } catch {
                print("Could not save")
            }
        }
    }
}

extension NewEntriesViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
