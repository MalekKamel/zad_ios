//
//  EditViewController.swift
//  Zad
//
//  Created by Sha on 9/4/17.
//  Copyright © 2017 A. All rights reserved.
//

import UIKit

class EditVC: UIViewController {
    
    @IBOutlet weak var editTextView: UITextView!
    var lecture: Lecture?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = lecture?.title
        editTextView.text = lecture?.details
    }

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        lecture?.details = editTextView.text
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        dismiss(animated: true, completion: nil)
    }
}
