//
//  MapViewController.swift
//  IOSProject
//
//  Created by Chitturi,Rakesh on 10/6/16.
//  Copyright © 2016 Chitturi,Rakesh. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Parse
import GoogleMaps
import GooglePlaces


class MapViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
    @IBOutlet weak var strartTourLBL: UIButton!
    @IBOutlet weak var map: MKMapView!
    var pointAnnotation:CustomPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    
    var myLoc:CLLocationManager!
    
    let coldenHall = CLLocationCoordinate2D(latitude: 40.350916, longitude: -94.882938)
    var libRegion = CLLocationCoordinate2D(latitude: 40.353615,longitude: -94.886056)
    var suRegion = CLLocationCoordinate2D(latitude: 40.351662,longitude: -94.883308)
    var adminRegion = CLLocationCoordinate2D(latitude: 40.353294,longitude: -94.883567)
    var wellsRegion = CLLocationCoordinate2D(latitude: 40.352784,longitude: -94.881666)
    var valkRegion = CLLocationCoordinate2D(latitude: 40.352723,longitude: -94.880363)
    var ronHoustRegion = CLLocationCoordinate2D(latitude: 40.350268,longitude: -94.887154)
    var buildingAnnoArray:[String:CLLocationCoordinate2D] = [:]
    var buildingLocations:[CLLocation] = []

    
    @IBAction func startTourBTN(sender: AnyObject) {
        let tour = strartTourLBL.titleForState(UIControlState.Normal)
        if tour == "Start Tour"{
            viewanoo()
            if CLLocationManager.locationServicesEnabled(){
                myLoc = CLLocationManager()
                myLoc.delegate = self
                myLoc.desiredAccuracy = kCLLocationAccuracyBestForNavigation
                myLoc.startUpdatingLocation()
                myLoc.requestAlwaysAuthorization()
                map.delegate = self
                map.mapType = MKMapType.Standard
                map.showsUserLocation = true
            }
            strartTourLBL.setTitle("End Tour", forState: UIControlState.Normal)
            strartTourLBL.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        }
        else{
            
        }
    }
    
    func allLocation(){
        for value in buildingAnnoArray.values{
            let locationLat = value.latitude
            let locationLong = value.longitude
            let currentLoc = CLLocation(latitude: locationLat, longitude: locationLong)
            buildingLocations.append(currentLoc)
        }
    }
    
    func buildingName(location:CLLocation) -> String{
        
        var returString = ""
        for (key,value) in buildingAnnoArray{
            let latitude = value.latitude
            let long = value.longitude
            if location.distanceFromLocation(CLLocation(latitude: latitude, longitude: long)) < 1.0{
                returString = key
            }
        }
        
        return returString
    }
    
    
    func nearestLocation(myLocation:CLLocation)-> CLLocation{
        var closestLocation: CLLocation!
        var smallestDistance: CLLocationDistance!
        
        for location in buildingLocations {
            let distance = myLocation.distanceFromLocation(location)
            if smallestDistance == nil || distance < smallestDistance {
                closestLocation = location
                smallestDistance = distance
            }
        }
        
        return closestLocation
    }

    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let myLocation = locations[locations.count-1] as CLLocation
        myLoc.stopUpdatingLocation()
        
        let coord = CLLocationCoordinate2DMake(myLocation.coordinate.latitude, myLocation.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.02,0.02)
        let region = MKCoordinateRegionMake(coord,span)
        self.map.setRegion(region, animated: true)
        
        var destination = nearestLocation(myLocation)
        if myLocation.distanceFromLocation(destination).isZero{
            print(destination)
            var mystry = UIStoryboard(name: "Main", bundle: nil)
            let details:DetailsofBuildingViewController = mystry.instantiateViewControllerWithIdentifier("vc") as! DetailsofBuildingViewController
            details.input = buildingName(destination)
            self.navigationController?.pushViewController(details, animated: true)
        }
        
        
    }
    
    
    func viewanoo(){
        for building in buildingAnnoArray.keys{
            pointAnnotation = CustomPointAnnotation()
            pointAnnotation.pinCustomImageName = "anotationPin"
            pointAnnotation.coordinate = buildingAnnoArray[building]!
            pointAnnotation.title = building
            pinAnnotationView = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: "pin")
            map.addAnnotation(pinAnnotationView.annotation!)
        }
        allLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         GMSServices.provideAPIKey("AIzaSyC9_jVOJhrKE4DlkgeFwXs5RXpSp-D6UhA")
         GMSPlacesClient.provideAPIKey("AIzaSyC9_jVOJhrKE4DlkgeFwXs5RXpSp-D6UhA")
        ProfessorsInbuilding.populateProfessors()
        map.mapType = MKMapType.Standard
        let region = MKCoordinateRegionMakeWithDistance(coldenHall, CLLocationDistance(100)*2.0, CLLocationDistance(60)*2.0)
        map.setRegion(region, animated: true)
        buildingAnnoArray = ["Colden Hall":coldenHall,"Owens Library":libRegion,"Student Union":suRegion,"Administration Building":adminRegion,"Wells Hall":wellsRegion,"Valk Center":valkRegion,"Ron Houston Center":ronHoustRegion]
        
        
        
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "pin"
        if annotation.isKindOfClass(MKUserLocation) {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.canShowCallout = true
            annotationView?.image = UIImage(named: "annotationPin")
            //annotationView!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

