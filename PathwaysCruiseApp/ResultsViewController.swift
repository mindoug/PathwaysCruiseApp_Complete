//
//  ResultsViewController.swift
//  PathwaysCruiseApp
//
//  Created by Mindy Douglas on 3/28/23.
//

import UIKit

class ResultsViewController: UIViewController {
    
    // values need to be initialized before we can use them
    // We could create an init function to do this, but instead we will start them out with an initial value
    var days: Int = 2
    var date: Date?
    var destination: String = ""
    var departure: String = ""
    var numberOfPeople: Int = 1
    var cabinSelection: String = "Interior"
    var itinerary: String = ""
    lazy var selectedCruise = cruises[0]
    var isPeak: Bool = false
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var resultsTextView: UITextView!
    @IBOutlet weak var numberStepper: UIStepper!
    @IBOutlet weak var interiorButton: UIButton!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var windowButton: UIButton!
    @IBOutlet weak var suiteButton: UIButton!
    @IBOutlet weak var balconyButton: UIButton!
    
let cruises = [
            Cruise(departure: "Mobile, AL", destination: "Western Caribbean", itinerary: "Mohogany Bay, Belize and Costa Maya", image: UIImage(named: "mobileBay")),
            Cruise(departure: "Mobile, AL", destination: "Bahamas", itinerary: "Bimini and Nassau", image: UIImage(named: "bahamas")),
           Cruise(departure: "San Francisco, CA", destination: "Mexico", itinerary: "San Diego and Ensenada", image: UIImage(named: "sanfran2")),
           Cruise(departure: "San Francisco, CA", destination: "Alaska", itinerary: "Sitka, Juneau and Glacier Bay National Park", image: UIImage(named: "bridge")),
           Cruise(departure: "Charleston, SC", destination: "Bahamas", itinerary: "Charleston, Nassau and Half Moon Cay", image: UIImage(named: "port")),
           Cruise(departure: "Charleston, SC", destination: "Caribbean", itinerary: "Cozumel and Yucatan", image: UIImage(named: "lighthouse")),
           Cruise(departure: "Cape Canaveral, FL", destination: "Bahamas", itinerary: "Bimini, Nassau, and Princess Cays", image: UIImage(named: "port2")),
           Cruise(departure: "Cape Canaveral, FL", destination: "Eastern Caribbean", itinerary: "Grand Turk and Amber Cove", image: UIImage(named: "cruise2")),
]

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    func initialize() {
        getCruise()
        imageView.image = selectedCruise.image
        resultsLabel.text = "\(destination) Cruise"
        resultsTextView.text = "Your \(days) day \(destination) cruise will depart from \(departure) on \(formatDateAsString(date: date!)) and travel to \(selectedCruise.itinerary)."
    }
    
    func formatDateAsString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
    
    func deselectAllButtons() {
        windowButton.isSelected = false
        interiorButton.isSelected = false
        balconyButton.isSelected = false
        suiteButton.isSelected = false
    }
    
    func getCruise() {
        switch destination {
        case "Mexico":
            selectedCruise = cruises[2]
        case "Caribbean":
            if departure == "Mobile" {
                selectedCruise = cruises[0]
            } else if departure == "Charleston" {
                selectedCruise = cruises[5]
            } else {
                selectedCruise = cruises[7]
            }
        case "Alaska":
            selectedCruise = cruises[3]
        case "Bahamas":
            if departure == "Mobile"{
                selectedCruise = cruises[1]
            } else if departure == "Charleston" {
                selectedCruise = cruises[4]
            } else {
                selectedCruise = cruises[6]
            }
        default:
            resultsTextView.text = "There are no cruises scheduled for this destination.  Please select another."
        }
    }
    
    func getPeakStatus(date: Date) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        
        if dateFormatter.string(from: date).contains("Aug") || dateFormatter.string(from: date).contains("Dec") {
            isPeak = true
        } else {
            isPeak = false
        }
        print("Peak status: \(isPeak)")
        return isPeak
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        numberLabel
            .text = Int(sender.value).description
        numberOfPeople = Int(sender.value)
        
        print("People: \(numberOfPeople)")
    }
    
    @IBAction func cabinButtonSelected(_ sender: UIButton) {
        deselectAllButtons()
        sender.isSelected = true
        cabinSelection = sender.titleLabel!.text ?? ""
        
        print("Cabin \(cabinSelection)")
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CostViewController {
            destination.cabinSelection = self.cabinSelection
            destination.numberOfPeople = self.numberOfPeople
            destination.days = self.days
            destination.isPeak = self.isPeak
        }
    }
}
