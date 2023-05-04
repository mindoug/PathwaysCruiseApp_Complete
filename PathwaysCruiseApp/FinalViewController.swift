//
//  FinalViewController.swift
//  PathwaysCruiseApp
//
//  Created by Mindy Douglas on 4/1/23.
//

import UIKit

class FinalViewController: UIViewController {
    
    var customerName: String = "Customer"

    @IBOutlet weak var textLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textLabel.text = "Thank you, \(customerName)! We look forward to sailing with you."
    }
}
