//
//  CityDetailsViewController.swift
//  Meteo
//
//  Created by Leo Marcotte on 02/11/2017.
//  Copyright © 2017 Leo Marcotte. All rights reserved.
//

import UIKit
import MapKit
import Material

class CityDetailsViewController: UIViewController {
    
    var city: City!

    fileprivate var mapView: MKMapView!
    fileprivate var cityNameLabel: UILabel!
    fileprivate var temperatureLabel: UILabel!
    fileprivate var humidityLabel: UILabel!
    fileprivate var pressureLabel: UILabel!
    fileprivate var sunriseLabel: UILabel!
    fileprivate var sunsetLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigationBar()
        prepareMapView()
        prepareCityNameLabel()
        prepareTemperatureLabel()
        prepareHumidityLabel()
        preparePressureLabel()
        prepareSunriseLabel()
        prepareSunsetLabel()
        
        let initialLocation = CLLocation(latitude: city.latitude, longitude: city.longitude)
        let regionRadius: CLLocationDistance = 10000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
}


// MARK: - NavigationBar
extension CityDetailsViewController {

    fileprivate func prepareNavigationBar() {
        navigationItem.backButton.tintColor = .white
    }
}


// MARK: - View
extension CityDetailsViewController {
    
    fileprivate func prepareMapView() {
        mapView = MKMapView()
        view.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        

    }
    
    fileprivate func prepareCityNameLabel() {
        cityNameLabel = UILabel()
        cityNameLabel.font = RobotoFont.bold(with: 26)
        cityNameLabel.text = city.name
        view.addSubview(cityNameLabel)
        
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        cityNameLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 16).isActive = true
        cityNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        cityNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        cityNameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    fileprivate func prepareTemperatureLabel() {
        temperatureLabel = UILabel()
        temperatureLabel.font = RobotoFont.medium(with: 18)
        temperatureLabel.text = "Temperature: \(String(format: "%.1f", city.celsius))℃"
        view.addSubview(temperatureLabel)
        
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 16).isActive = true
        temperatureLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        temperatureLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        temperatureLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    fileprivate func prepareHumidityLabel() {
        humidityLabel = UILabel()
        humidityLabel.font = RobotoFont.medium(with: 18)
        humidityLabel.text = "Humidity: \(city.humidity)%"
        view.addSubview(humidityLabel)
        
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 8).isActive = true
        humidityLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        humidityLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        humidityLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    fileprivate func preparePressureLabel() {
        pressureLabel = UILabel()
        pressureLabel.font = RobotoFont.medium(with: 18)
        pressureLabel.text = "Pressure: \(city.pressure)hPa"
        view.addSubview(pressureLabel)
        
        pressureLabel.translatesAutoresizingMaskIntoConstraints = false
        pressureLabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: 8).isActive = true
        pressureLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        pressureLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        pressureLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    fileprivate func prepareSunriseLabel() {
        sunriseLabel = UILabel()
        sunriseLabel.font = RobotoFont.medium(with: 18)
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        let dateString = formatter.string(from: city.sunrise)
        
        sunriseLabel.text = "Sunrise: \(dateString)"
        view.addSubview(sunriseLabel)
        
        sunriseLabel.translatesAutoresizingMaskIntoConstraints = false
        sunriseLabel.topAnchor.constraint(equalTo: pressureLabel.bottomAnchor, constant: 8).isActive = true
        sunriseLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        sunriseLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        sunriseLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    fileprivate func prepareSunsetLabel() {
        sunsetLabel = UILabel()
        sunsetLabel.font = RobotoFont.medium(with: 18)

        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        let dateString = formatter.string(from: city.sunset)
        
        sunsetLabel.text = "Sunset: \(dateString)"
        view.addSubview(sunsetLabel)
        
        sunsetLabel.translatesAutoresizingMaskIntoConstraints = false
        sunsetLabel.topAnchor.constraint(equalTo: sunriseLabel.bottomAnchor, constant: 8).isActive = true
        sunsetLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        sunsetLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        sunsetLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
}
