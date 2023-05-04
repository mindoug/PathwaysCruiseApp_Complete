//
//  CostViewController.swift
//  PathwaysCruiseApp
//
//  Created by Mindy Douglas on 3/31/23.
//

import UIKit

class CostViewController: UIViewController {
    
    @IBOutlet weak var perPersonLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var peakTravelLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var cabinSelection: String = "Interior"
    var isPeak: Bool = false
    var numberOfPeople: Int = 1
    var days: Int = 3
    var customerName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        displayCost()
    }
    
    func initialize() {
        nameTextField.text = ""
        emailTextField.text = ""
        messageLabel.text = "Sign up for updates and to reserve your cabin."
        submitButton.isEnabled = false
    }
    
    func getCabinCost(cabinSelection: String) -> Double {
        var cabinCost: Double = 129.00
        switch cabinSelection {
        case "Interior":
            cabinCost = 129.00
        case "Window":
            cabinCost = 209.00
        case "Balcony":
            cabinCost = 365.00
        case "Suite":
            cabinCost = 429.00
        default:
            cabinCost = 129.00
        }
        return cabinCost
    }
    
    func calculatePeakFee(isPeak: Bool, numberOfPeople: Int, days: Int) -> Double {
        var peak: Double = 0.00
        if isPeak {
            peak = Double(numberOfPeople) * Double(days) * 150.00
        }
        return peak
    }
    
    func getCost(cabinCost: Double, days: Int, numberOfPeople: Int, isPeak: Bool) -> Double {
        var subtotal = cabinCost * Double(numberOfPeople) * Double(days)
        if isPeak {
            subtotal += calculatePeakFee(isPeak: isPeak, numberOfPeople: numberOfPeople, days: days)
        }
        return subtotal
    }
    
    func displayCost() {
        let perPerson = getCabinCost(cabinSelection: cabinSelection) * Double(days)
        let perGroup = Double(numberOfPeople) * perPerson
        let peak = calculatePeakFee(isPeak: isPeak, numberOfPeople: numberOfPeople, days: days)
        let tax = (perGroup + peak) + 0.09
       let total = getCost(cabinCost: getCabinCost(cabinSelection: cabinSelection), days: days, numberOfPeople: numberOfPeople, isPeak: isPeak) + tax
        
        // currency formatter
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        
        let perGroupFormatted = currencyFormatter.string(from: perGroup as NSNumber)
        let perPersonFormatted = currencyFormatter.string(from: perPerson as NSNumber)
        let peakFeeFormatted = currencyFormatter.string(from: peak as NSNumber)
        let taxFormatted = currencyFormatter.string(from: tax as NSNumber)
        let totalFormatted = currencyFormatter.string(from: total as NSNumber)
        
        perPersonLabel.text = perPersonFormatted
        groupLabel.text = perGroupFormatted
        peakTravelLabel.text = peakFeeFormatted
        taxLabel.text = taxFormatted
        totalLabel.text = totalFormatted
    }
    
    
    @IBAction func textEntered(_ sender: UITextField) {
        if let name = nameTextField.text, let email = emailTextField.text {
            if (name.isEmpty || name.count < 2) && email.isEmpty {
                submitButton.isEnabled = false
                messageLabel.text = "Please enter a valid name & email."
            } else if name.count > 2 && !email.contains("@") && !email.contains(".") {
                submitButton.isEnabled = false
                messageLabel.text = "Please enter a valid email."
            } else if email.contains("@") && email.contains(".") && name.count < 2 {
                submitButton.isEnabled = false
                messageLabel.text = "Please enter first and last name."
            } else {
                submitButton.isEnabled = true
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FinalViewController {
            destination.customerName = self.nameTextField.text ?? "" 
        }
    }
}
