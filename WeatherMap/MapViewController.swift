//
//  MapViewController.swift
//  WeatherMap
//
//  Created by Kamil Chmiel on 15.10.2018.
//  Copyright © 2018 kamilchmiel. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import RealmSwift
import Alamofire
import SwiftyJSON

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "YOUR_API_KEY"
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        
        if CLLocationManager.locationServicesEnabled() == true {
            
            if CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
            }
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.startUpdatingLocation()
            
        } else {
            print("You have to turn on the location services to be able to get the weather")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
 
            setLocationPin(location: location)
            
            getWeatherData(lon: Double(location.coordinate.longitude), lat: Double(location.coordinate.latitude)) { (data) in
                let newLocation = LocationModel()
                newLocation.name = data.city
                newLocation.latitude = location.coordinate.latitude
                newLocation.longitude = location.coordinate.longitude
                let realm = try! Realm()
                try! realm.write {
                    realm.add(newLocation)
                }
                
                self.updateUIWithWeatherData(city: data.city ,temperature: data.temperature, description: data.desc)
            }
        }
    }
    
    func setLocationPin(location: CLLocation) {
        let position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: position, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = position
        mapView.addAnnotation(annotation)
    }
    
    func switchLocation(lon: Double, lat: Double) {
        setLocationPin(location: CLLocation.init(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon)))
        getWeatherData(lon: lon, lat: lat) { (data) in
            self.updateUIWithWeatherData(city: data.city ,temperature: data.temperature, description: data.desc)
        }
    }
    
    func getWeatherData(lon: Double, lat: Double, completion: @escaping (_ result: WeatherDataModel) -> Void){
        
        // NETWORKING
        let params : [String : Any] = ["lat" : lat, "lon" : lon, "appid" : APP_ID]
        
        Alamofire.request(WEATHER_URL, method: .get, parameters: params).responseJSON {
            response in
            if(response.result.isSuccess){
                let weatherJSON: JSON = JSON(response.result.value!)
                
                if let temperature =  weatherJSON["main"]["temp_max"].double {
                    
                    let weatherData = WeatherDataModel()
                    weatherData.city = weatherJSON["name"].stringValue
                    weatherData.desc = weatherJSON["weather"].array![0]["description"].stringValue
                    weatherData.temperature = Int(temperature - 273.15)
                    
                    completion(weatherData)
                }
                else{
                    
                }
            }
            else{
                print("Error \(response.result.error)")
            }
            
        }
        
    }
    
    func updateUIWithWeatherData(city: String, temperature: Int, description: String) {
        cityLabel.text = city
        temperatureLabel.text = "\(temperature) st"
        descriptionLabel.text = "Description: " + description
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Unable to access your current location")
    }
}
