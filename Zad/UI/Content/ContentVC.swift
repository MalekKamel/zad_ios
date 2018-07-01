//
//  ContentViewController.swift
//  Zad
//
//  Created by Sha on 9/2/17.
//  Copyright © 2017 A. All rights reserved.
//

import UIKit

class ContentVC: UIViewController {
    

    @IBOutlet weak var contentTextView: UITextView!
 
    var lecture: Lecture?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let lect = lecture{
            title = lect.title
            contentTextView.text = lect.details
        }
    }
    
}
