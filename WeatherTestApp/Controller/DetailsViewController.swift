//
//  DetailsViewController.swift
//  WeatherTestApp
//
//  Created by Roman Korobskoy on 30.12.2021.
//

import UIKit
import SwiftSVG

class DetailsViewController: UIViewController {

    @IBOutlet var cityNameLabel: UILabel!
    
    @IBOutlet var viewCity: UIView!
    @IBOutlet var conditionLabel: UILabel!
    @IBOutlet var tempCity: UILabel!
    
    @IBOutlet var pressureLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var minTempLabel: UILabel!
    @IBOutlet var maxTempLabel: UILabel!
    
    var weatherModel: Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshLabels()
    }
    
    func refreshLabels() {
        cityNameLabel.text = weatherModel?.name
        let url = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(weatherModel!.conditionCode).svg")
        let weatherImage = UIView(SVGURL: url!) { image in
            image.resizeToFit(self.viewCity.bounds)
        }
        self.viewCity.addSubview(weatherImage)
        
        conditionLabel.text = weatherModel?.conditionString
        tempCity.text = weatherModel?.tempertatureString
        pressureLabel.text = "\((weatherModel?.pressureMm)!)"
        windSpeedLabel.text = "\((weatherModel?.windSpeed)!)"
        minTempLabel.text = "\((weatherModel?.tempMin)!)"
        maxTempLabel.text = "\((weatherModel?.tempMax)!)"
    }
}
