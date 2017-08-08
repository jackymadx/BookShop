//
//  MapFile.swift
//  Project2
//
//  Created by UserMOL on 01/08/2017.
//  Copyright © 2017 UserMOL. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import GooglePlaces


class MapViewController: UIViewController {

    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var mapMarkerInfoView : MarkerInfoView!
    var mapView: GMSMapView!
    var tappedMarker : GMSMarker?
    var customInfoWindow : CustomInfoWindow?
    var count: Int = 0
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
  
    // An array to hold the list of likely places.
    var likelyPlaces: [GMSPlace] = []
    
    // The currently selected place.
    var selectedPlace: GMSPlace?
    
    // A default location to use when location permission is not granted.
    let defaultLocation = CLLocation(latitude: 3.769405, longitude: 101.199)
    
    // Set the status bar style to complement night-mode.
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // You don't need to modify the default init(nibName:bundle:) method.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        placesClient = GMSPlacesClient.shared()
        
        // Create a map.
        let camera = GMSCameraPosition.camera(
            withLatitude:defaultLocation.coordinate.latitude,
            longitude:   defaultLocation.coordinate.longitude,
            zoom: zoomLevel)
        
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = true
        mapView.isTrafficEnabled    = true
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        mapView.delegate = self

        
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "Style", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        
    
        // Add the map to the view, hide it until we've got a location update.
        self.view = mapView
        mapView.isHidden = true
        IJProgressView.shared.hideProgressView()
        
        let button:UIButton = UIButton(frame: CGRect(x:25,y:80,width:75,height: 40))
        button.setTitle("Details", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.backgroundColor = UIColor.orange
        //myFirstButton.addTarget(self, action: #selector(myClass.pressed(_:)), forControlEvents: .TouchUpInside)
        self.mapView.addSubview(button)
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 1.0
        
       // self.view.insertSubview(googleMapView, atIndex: 0)
       // self.view.insertSubview(yourButton, atIndex: 1)
    }
    
}
    // Delegates to handle events for the location manager.
extension MapViewController : CLLocationManagerDelegate , GMSMapViewDelegate {
        // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let location: CLLocation = locations.last!
           
            let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                                  longitude: location.coordinate.longitude,
                                                  zoom: zoomLevel)

            if mapView.isHidden {
                mapView.isHidden = false
                mapView.camera = camera
            } else {
                mapView.animate(to: camera)
            }
            
            self.tappedMarker = GMSMarker(position:location.coordinate)
            self.tappedMarker?.title = "My Location"
            self.tappedMarker?.icon = GMSMarker.markerImage(with:.gray)
            //self.tappedMarker?.infoWindowAnchor = CGPoint(x: 10.5, y: 70.5)
            //self.tappedMarker?.tracksInfoWindowChanges = false
            self.tappedMarker?.isTappable =  true
            self.tappedMarker?.isDraggable = true
            //self.tappedMarker?.appearAnimation = GMSMarkerAnimation(rawValue: 2)!
            self.tappedMarker?.icon = UIImage(named:"fly")
        
            if count == 0 {
              self.tappedMarker?.map = mapView
              mapView.selectedMarker = self.tappedMarker
                
              count += 1
            }
        
            locationManager.stopUpdatingLocation()
           // listLikelyPlaces()
        }
        
        // Handle authorization for the location manager.
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            switch status {
            case .restricted:
                print("Location access was restricted.")
            case .denied:
                print("User denied access to location.")
                // Display the map using the default location.
                mapView.isHidden = false
            case .notDetermined:
                print("Location status not determined.")
            case .authorizedAlways: fallthrough
            case .authorizedWhenInUse:
                print("Location status is OK.")
        }
    }
    

    
    private func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Void {
        
        //myFirstButton.addTarget(self, action: "pressed:", forControlEvents: .TouchUpInside)
        print("didTap")
    }
    
    func mapView(_ mapView: GMSMapView,markerInfoWindow marker: GMSMarker) -> UIView? {
        print("Calling")
        let infoWindow = Bundle.main.loadNibNamed("CustomInfoWindow", owner: self, options: nil)?.first as!
        CustomInfoWindow
        
        print("Calling haha")
        
        infoWindow.customWindowLabel.text = "My location";
        
        return infoWindow
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
         print("calling 2")
        let infoWindow = Bundle.main.loadNibNamed("CustomInfoWindow", owner: self, options: nil)?.first! as! CustomInfoWindow
        
        
        return infoWindow
    }
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinate)
        //marker.map = mapView
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            locationManager.stopUpdatingLocation()
            print("Error: \(error)")
    }
        
    func getDistanceMetresBetweenLocationCoordinates(coord1: CLLocationCoordinate2D, coord2: CLLocationCoordinate2D) -> Double {
            let location1 = CLLocation(latitude: coord1.latitude, longitude: coord1.longitude)
            let location2 = CLLocation(latitude: coord2.latitude, longitude: coord2.longitude)
            return location1.distance(from: location2)
    }

}


