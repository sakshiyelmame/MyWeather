//
//  ViewController.swift
//  MyWeather
//
//  Created by Sakshi Yelmame on 17/03/23.
//

import UIKit
import CoreLocation
// location : CoreLocation
// tableView
// customCell : CollectionView
// API / request to get data

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    var dailyWeather = [dailyWeatherEntry]()
    var hourlyModels = [HourlyWeatherEntry]()
    let locationManager = CLLocationManager()
    var currentLocation : CLLocation?
    var current: CurrentlyWeather?
    @IBOutlet var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register 2 cell
        
        table.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        table.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        view.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
    }
    // Location
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty{
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
    func requestWeatherForLocation() {
        guard let currentLocation = currentLocation else {
            return
        }
        let long = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude
        let url = "https://api.darksky.net/forecast/ddcc4ebb2a7c9930b90d9e59bda0ba7a/\(lat),\(long)?exclude=[flagsminutely"
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            //   print(url)
            // validation
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            // convert data to models/ some object
            var json: WeatherRes?
            do {
                json = try JSONDecoder().decode(WeatherRes.self, from: data)
            }
            catch {
                print("error: \(error)")
            }
            guard let result = json else {
                return
            }
            //  print(result.currently.summary)
            let entries = result.daily.data
            self.dailyWeather.append(contentsOf: entries)
            let current = result.currently
            self.current = current
            self.hourlyModels = result.hourly.data
            // update user interface
            DispatchQueue.main.async {
                self.table.reloadData()
                self.table.tableHeaderView = self.createTableHeader()
            }
        }).resume()
        // print("\(long) | \(lat)")
    }
    func createTableHeader() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height/4))
        headerView.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        let locationLabel = UILabel(frame: CGRect(x: 10, y: 10, width: view.frame.size.width, height: headerView.frame.size.height/4))
        let summaryLabel = UILabel(frame: CGRect(x: 10, y: 10+locationLabel.frame.size.height, width: view.frame.size.width, height: headerView.frame.size.height/4))
        let tempLabel = UILabel(frame: CGRect(x: 10, y: 10+summaryLabel.frame.size.height, width: view.frame.size.width, height: headerView.frame.size.height/1))
        
        headerView.addSubview(locationLabel)
        headerView.addSubview(tempLabel)
        headerView.addSubview(summaryLabel)
        
        tempLabel.textAlignment = .center
        locationLabel.textAlignment = .center
        summaryLabel.textAlignment = .center
        
        locationLabel.text = "Current Location"
        
        guard let currentWeather = self.current else {
            return UIView()
        }
        tempLabel.text = "\(currentWeather.temperature)°"
        tempLabel.font = UIFont(name: "Helvetica-Bold", size: 32)
        summaryLabel.text = self.current?.summary
        
        return headerView
    }
    
    // Table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            // 1 cell that is collectionTableViewCell
            return 1
        }
        // return dailyWeather count
        return dailyWeather.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HourlyTableViewCell.identifier, for: indexPath) as! HourlyTableViewCell
            cell.configure(with: hourlyModels)
            cell.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        cell.configure(with: dailyWeather[indexPath.row])
        cell.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

