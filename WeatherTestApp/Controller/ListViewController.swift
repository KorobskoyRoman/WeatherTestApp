//
//  ListViewController.swift
//  WeatherTestApp
//
//  Created by Roman Korobskoy on 30.12.2021.
//

import UIKit
import SwiftSVG

class ListViewController: UITableViewController {
    
    let emptyCity = Weather()
    var citiesArray = [Weather]()
    var nameCitiesArray = ["Москва", "Торонто", "Санкт-Петербург", "Токио", "Краснодар", "Копенгаген", "Саппоро", "Аомори", "Париж", "Барселона"]
    var filteredCityArray = [Weather]()
    let networkManager = NetworkManager()
    let searchController = UISearchController(searchResultsController: nil)
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if citiesArray.isEmpty {
            citiesArray = Array(repeating: emptyCity, count: nameCitiesArray.count)
        }
        
        addCities()
        self.setupSearchController()
    }
    
    @IBAction func pressAddButton(_ sender: Any) {
        alertAddCity(name: "Город", placeholder: "Введите название города") { city in
            self.nameCitiesArray.append(city)
            self.citiesArray.append(self.emptyCity)
            self.addCities()
        }
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    
    func addCities() {
        getCityWeather(citiesArray: self.nameCitiesArray) { index, weather in
            
            self.citiesArray[index] = weather
            self.citiesArray[index].name = self.nameCitiesArray[index]
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, completionHandler in
            let editingRow = self.nameCitiesArray[indexPath.row]
            if let index = self.nameCitiesArray.firstIndex(of: editingRow) {
                if self.isFiltering {
                    self.filteredCityArray.remove(at: index)
                } else {
                    self.citiesArray.remove(at: index)
                }
            }
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCityArray.count
        }
        return citiesArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListCell
        var weather = Weather()
        if isFiltering {
            weather = filteredCityArray[indexPath.row]
        } else {
            weather = citiesArray[indexPath.row]
        }
        
        cell.configure(weather: weather)

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            if isFiltering {
                let filter = filteredCityArray[indexPath.row]
                let destVC = segue.destination as! DetailsViewController
                destVC.weatherModel = filter
            } else {
                let cityWeather = citiesArray[indexPath.row]
                let destVC = segue.destination as! DetailsViewController
                destVC.weatherModel = cityWeather
            }
        }
    }
}

extension ListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredCityArray = citiesArray.filter {
            $0.name.contains(searchText)
        }
        tableView.reloadData()
    }
}
