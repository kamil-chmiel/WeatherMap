//
//  LocationsViewController.swift
//  WeatherMap
//
//  Created by Kamil Chmiel on 15.10.2018.
//  Copyright © 2018 kamilchmiel. All rights reserved.
//

import UIKit
import RealmSwift

class LocationsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var locations: [LocationModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadLocations()
    }

    func loadLocations() {
        let realm = try! Realm()
        locations = Array(realm.objects(LocationModel.self))
        tableView.reloadData()
    }
}

extension LocationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let locationCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
        locationCell.textLabel?.text = locations[indexPath.row].name
        
        return locationCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let mapVC = tabBarController?.viewControllers![0] as? MapViewController {
            let chosenLocation = locations[indexPath.row]
            mapVC.switchLocation(lon: chosenLocation.longitude, lat: chosenLocation.latitude)
            tabBarController?.selectedIndex = 0
        }
    }
}
