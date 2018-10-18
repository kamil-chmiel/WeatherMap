//
//  LocationsRouter.swift
//  WeatherMap
//
//  Created by Kamil Chmiel on 18.10.2018.
//  Copyright (c) 2018 kamilchmiel. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol LocationsRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol LocationsDataPassing
{
  var dataStore: LocationsDataStore? { get }
}

class LocationsRouter: NSObject, LocationsRoutingLogic, LocationsDataPassing
{
  weak var viewController: LocationsViewController?
  var dataStore: LocationsDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: LocationsViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: LocationsDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
