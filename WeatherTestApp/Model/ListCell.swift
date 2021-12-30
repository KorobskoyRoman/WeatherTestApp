//
//  ListCell.swift
//  WeatherTestApp
//
//  Created by Roman Korobskoy on 30.12.2021.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet var nameCityLabel: UILabel!
    @IBOutlet var conditionCityLabel: UILabel!
    @IBOutlet var tempCityLabel: UILabel!
    
    func configure(weather: Weather) {
        self.nameCityLabel.text = weather.name
        self.conditionCityLabel.text = weather.conditionString
        self.tempCityLabel.text = weather.tempertatureString
    }
}
