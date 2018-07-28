//
//  NewTripViewController.swift
//  Travelogue
//
//  Created by Nathaniel Banderas on 7/27/18.
//  Copyright © 2018 Nathaniel Banderas. All rights reserved.
//

import UIKit

class NewTripViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        titleTextField.resignFirstResponder()
    }
    
    @IBAction func saveTrip(_ sender: Any) {
        let trip = Trip(title: titleTextField.text ?? "")
        
        do {
            try trip?.managedObjectContext?.save()
            
            self.navigationController?.popViewController(animated: true)
        } catch {
            print("Could not save trip")
        }
    }
}

extension NewTripViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
