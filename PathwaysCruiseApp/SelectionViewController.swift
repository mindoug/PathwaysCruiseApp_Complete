//
//  SelectionViewController.swift
//  PathwaysCruiseApp
//
//  Created by Mindy Douglas on 3/27/23.
//

import UIKit

class SelectionViewController: UIViewController {
    
    var dateSelection: Date? = .distantFuture
    var daysSelection: Int = 4
    var departureSelection: String = ""
    var destinationSelection: String = ""
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var daysSlider: UISlider!
    @IBOutlet weak var numberOfDaysLabel: UILabel!
    @IBOutlet weak var alaskaButton: UIButton!
    @IBOutlet weak var bahamasButton: UIButton!
    @IBOutlet weak var caribbeanButton: UIButton!
    @IBOutlet weak var mexicoButton: UIButton!
    @IBOutlet weak var capeButton: UIButton!
    @IBOutlet weak var charlestonButton: UIButton!
    @IBOutlet weak var mobileButton: UIButton!
    @IBOutlet weak var sanFranButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    func deselectAllDepartureButtons() {
        charlestonButton.isSelected = false
        sanFranButton.isSelected = false
        mobileButton.isSelected = false
        capeButton.isSelected = false
    }
    
    func getDepartureLocations() {
        hideDepartureButtons()
        
        switch destinationSelection {
        case "Bahamas":
            mobileButton.isHidden = false
            capeButton.isHidden = false
            charlestonButton.isHidden = false
        case "Mexico":
            sanFranButton.isHidden = false
        case "Caribbean":
            mobileButton.isHidden = false
            charlestonButton.isHidden = false
            capeButton.isHidden = false
        case "Alaska":
            sanFranButton.isHidden = false
        default:
            hideDepartureButtons()
        }
    }
    
    func hideDepartureButtons() {
        charlestonButton.isHidden = true
        sanFranButton.isHidden = true
        mobileButton.isHidden = true
        capeButton.isHidden = true
    }
    
    func deselectAllDestinationButtons() {
        bahamasButton.isSelected = false
        mexicoButton.isSelected = false
        caribbeanButton.isSelected = false
        alaskaButton.isSelected = false
    }
    
    @IBAction func departureButtonSelected(_ sender: UIButton) {
//        print(sender.titleLabel?.text ?? "error")
        
        sender.isSelected = true
        departureSelection = sender.titleLabel?.text ?? ""
        print("Departure selection: \(departureSelection)")
    }
    
    @IBAction func destinationButtonSelected(_ sender: UIButton) {
//        print(sender.titleLabel?.text ?? "error")
        deselectAllDestinationButtons()
        sender.isSelected = true
        destinationSelection = sender.titleLabel?.text ?? ""
        getDepartureLocations()
        print("Destination selection: \(destinationSelection)")
    }
    
    @IBAction func dateSelected(_ sender: UIDatePicker) {
//        print(datePicker.date)
        dateSelection = datePicker.date
        print("Date selection: \(String(describing: dateSelection))")
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
//        print(sender.value)
        daysSelection = Int(sender.value)
        numberOfDaysLabel.text = String("\(daysSelection) days")
        print("Selected days: \(daysSelection)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ResultsViewController {
            destination.departure = self.departureSelection
            destination.destination = self.destinationSelection
            destination.days = self.daysSelection
            destination.date = self.dateSelection 
        }
    }
}
