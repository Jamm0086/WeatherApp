//
//  WeatherCitiesTableViewController.swift
//  WeatherApp
//
//  Created by Jorge Mendoza Martínez on 2/24/18.
//  Copyright © 2018 Jorge Mendoza Martínez. All rights reserved.
//

import UIKit

class WeatherCitiesTableViewController: WeatherAppTableViewController, WeatherCitiesListModelDelegate {
    
    let list = WeatherCitiesListModel()
    var refresher: UIRefreshControl!
    
    override func viewDidLoad() {
        navigationBarTextStyle(title: "Weather")
        list.delegate = self
        prepareRefresher()
        loadCities()
    }
    
    func prepareRefresher() {
        refresher = UIRefreshControl()
        tableView.addSubview(refresher)
        let font = UIFont(name: "Arvo", size: 14)!
        let attributes =  [NSAttributedStringKey.font: font, NSAttributedStringKey.foregroundColor: UIColor.detailTitleColor]
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: attributes)
        refresher.addTarget(self, action: #selector(updateLocationAndCities), for: .valueChanged)
    }
    
    func loadCities() {
        list.loadCities()
    }
    @objc func updateLocationAndCities() {
        if RestAPIClient.isConnectedToInternet {
            list.loadCitiesAndUpdateLocation()
        } else {
            refresher.endRefreshing()
            WeatherAppViewController.checkInternetConnection()
        }
        
    }
    
    // MARK: - WeatherCitiesListModelDelegate
    func updateCompleted() {
        self.tableView.reloadData()
        refresher.endRefreshing()
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if list.citiesList == nil {
            return 0
        }
        return (list.citiesList?.count)!
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherTableViewCell
        
        let weatherCity = list.citiesList![indexPath.row]
        
        cell.cityNameLabel.text = weatherCity.name
        let temp = weatherCity.convertyKelvinToCelsiusString(kelvin: weatherCity.temp)
        cell.tempetureLabel.text = "Tempeture: \(temp) Cº"
        if let image = weatherCity.weatherImage {
            cell.weatherImage.image = image
        }
        return cell
    }
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weatherCity = list.citiesList![indexPath.row]
        performSegue(withIdentifier: "showDetailSegue", sender: weatherCity)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.lightGray
        
        let headerLabel = UILabel(frame: CGRect(x: 29, y: 5, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        if list.citiesList != nil {
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy h:mm:ss a"
            let text = "Last update: \(formatter.string(from: date))"
            headerLabel.attributedText = NSMutableAttributedString.tableViewHeaderFormatter(text: text)
        }
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    
    // MARK: - Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailSegue" {
            let city = sender as! WeatherCityModel
            let detailViewControler = segue.destination as! WeatherCityDetailViewController
            detailViewControler.weatherCity = city
        }
    }
}
