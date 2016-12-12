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
    var neareatLocactionCheck = true
    
    var myLocation:CLLocationManager!
    
    let coldenHall = CLLocationCoordinate2D(latitude: 40.350916, longitude: -94.882938)
    var library = CLLocationCoordinate2D(latitude: 40.353615,longitude: -94.886056)
    var studentUnion = CLLocationCoordinate2D(latitude: 40.351662,longitude: -94.883308)
    var adminBuilding = CLLocationCoordinate2D(latitude: 40.353294,longitude: -94.883567)
    var wellsHall = CLLocationCoordinate2D(latitude: 40.352784,longitude: -94.881666)
    var valkCenter = CLLocationCoordinate2D(latitude: 40.352723,longitude: -94.880363)
    var ronHouston = CLLocationCoordinate2D(latitude: 40.350268,longitude: -94.887154)
    var buildingAnnotaionArray:[String:CLLocationCoordinate2D] = [:]
    var buildingLocations:[CLLocation] = []
    var builingCount = 0
    var buildingArray:[String]!
    
    //This function invokes when map view loads and enables google api and populates data to appropriate view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.tintColor = UIColor.whiteColor()
        self.tabBarController?.tabBar.barTintColor = UIColor(red: 37.0/255, green: 39.0/255, blue: 42.0/255, alpha: 1)
        self.tabBarController?.tabBar.translucent = false
        
        GMSServices.provideAPIKey("AIzaSyC9_jVOJhrKE4DlkgeFwXs5RXpSp-D6UhA")
        GMSPlacesClient.provideAPIKey("AIzaSyC9_jVOJhrKE4DlkgeFwXs5RXpSp-D6UhA")
        
        ProfessorsInbuilding.populateProfessors()
        
        map.mapType = MKMapType.Standard
        let region = MKCoordinateRegionMakeWithDistance(coldenHall, CLLocationDistance(100)*2.0, CLLocationDistance(60)*2.0)
        map.setRegion(region, animated: true)
        
        buildingAnnotaionArray = ["Valk Center":valkCenter,"Wells Hall":wellsHall,"Administration Building":adminBuilding,"Owens Library":library,"Student Union":studentUnion,"Colden Hall":coldenHall,"Ron Houston Center":ronHouston]
    }

    //This function invokes when Start Button is clicked and take the user to the tour
    @IBAction func startTourBTN(sender: AnyObject) {
        
        let tour = strartTourLBL.titleForState(UIControlState.Normal)
        
        if tour == "Start Tour"{
            displayAnnotatons()
            
            if CLLocationManager.locationServicesEnabled(){
                myLocation = CLLocationManager()
                myLocation.delegate = self
                myLocation.desiredAccuracy = kCLLocationAccuracyBestForNavigation
                myLocation.startUpdatingLocation()
                myLocation.requestAlwaysAuthorization()
                map.delegate = self
                map.mapType = MKMapType.Standard
                map.showsUserLocation = true
            }
            strartTourLBL.setTitle("End Tour", forState: UIControlState.Normal)
            strartTourLBL.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
            buildingArray = ["Valk Center","Wells Hall","Administration Building","Owens Library","Student Union","Colden Hall","Ron Houston Center"]
        }else{
            neareatLocactionCheck = true
            strartTourLBL.setTitle("Start Tour", forState: UIControlState.Normal)
            strartTourLBL.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            let overlays = map.overlays
            map.removeOverlays(overlays)
            displayMessage("Your tour has been successfully ended")
        }
    }
    
    //This function checks to which building the user is near by
    func nearestLocation(myLocation:CLLocation)-> CLLocationCoordinate2D{
        var name:String = ""
        var temparoryArray:[String] = []
        var closestLocation: CLLocationCoordinate2D!
        var smallestDistance: CLLocationDistance!
        for (key,value) in buildingAnnotaionArray{
            let distance = myLocation.distanceFromLocation(CLLocation(latitude: value.latitude, longitude: value.longitude))
            if smallestDistance == nil || distance < smallestDistance {
                name = key
                closestLocation = value
                smallestDistance = distance
            }
        }
        var index = 0
        for i in 0...buildingArray.count-1{
            if name == buildingArray[i]{
                index = i
            }
        }
        for i in index...buildingArray.count-1{
            temparoryArray.append(buildingArray[i])
        }
        for i in 0..<buildingArray.count - index{
            temparoryArray.append(buildingArray[i])
        }
        return closestLocation
    }
    
    //this function compare the given point is wether in or out of the region
    func comparePointNearTheRegions( presentLocation:CLLocationCoordinate2D,destination:CLLocationCoordinate2D) -> Bool{
        
        var rectRegion:MKMapRect!
        var bool:Bool = false
        let region:MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(destination, 50, 50)
        let a = MKMapPointForCoordinate(CLLocationCoordinate2DMake(region.center.latitude + region.span.latitudeDelta / 2,region.center.longitude - region.span.longitudeDelta / 2))
        let b = MKMapPointForCoordinate(CLLocationCoordinate2DMake(region.center.latitude - region.span.latitudeDelta / 2,region.center.longitude + region.span.longitudeDelta / 2))
        rectRegion = MKMapRectMake(min(a.x,b.x),min(b.y,a.y), abs(b.x-a.x),abs(b.y-a.y))
        
        if MKMapRectContainsPoint(rectRegion, MKMapPointForCoordinate(presentLocation)){
            bool = true
            return true
            
        }
        return bool
    }
    
    var destination:CLLocationCoordinate2D!
    
    //this function updates the user location and invokes every time the user makes his move
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let presentLocation = locations[locations.count-1] as CLLocation
        let presentcoordinates = CLLocationCoordinate2DMake(presentLocation.coordinate.latitude, presentLocation.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(presentcoordinates, 10, 10)
        self.map.setRegion(region, animated: true)
        
        if neareatLocactionCheck{
            destination = nearestLocation(presentLocation)
            neareatLocactionCheck = false
        }
        
        if comparePointNearTheRegions(presentcoordinates,destination: destination){
            let mystoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let details:DetailsofBuildingViewController = mystoryBoard.instantiateViewControllerWithIdentifier("vc") as! DetailsofBuildingViewController
            details.input = buildingName(CLLocation(latitude:destination.latitude,longitude: destination.longitude))
            self.navigationController?.pushViewController(details, animated: true)
            if buildingArray.count > 0{
                buildingArray.removeAtIndex(0)
                destination = buildingAnnotaionArray[buildingArray[0]]
            }else{
                let overlays = map.overlays
                map.removeOverlays(overlays)
               displayMessage("Thank you,You have successfully completed Campus Tour")
            }
            
        }else{
            showRouteOnMap(presentcoordinates,destination:destination)
        }
    }
    
    func showRouteOnMap(currentLocation:CLLocationCoordinate2D,destination:CLLocationCoordinate2D) {
        
        let request = MKDirectionsRequest()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: currentLocation, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination, addressDictionary: nil))
        request.transportType = .Any
        
        let directions = MKDirections(request: request)
        
        directions.calculateDirectionsWithCompletionHandler { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            
            if (unwrappedResponse.routes.count > 0) {
                self.map.addOverlay(unwrappedResponse.routes[0].polyline)
                self.map.setVisibleMapRect(unwrappedResponse.routes[0].polyline.boundingMapRect, animated: true)
            }
        }
        
    }
    
    //this function draws the route between two given locations
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        var polyline = MKPolylineRenderer()
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.fillColor = UIColor.blueColor().colorWithAlphaComponent(0.2)
            polylineRenderer.strokeColor = UIColor.blueColor().colorWithAlphaComponent(0.7)
            polylineRenderer.lineWidth = 5
            polyline =  polylineRenderer
        }
        return polyline
    }
    
    //this function show all the annotaion on the map with appropriate title
    func displayAnnotatons(){
        for building in buildingAnnotaionArray.keys{
            pointAnnotation = CustomPointAnnotation()
            pointAnnotation.pinCustomImageName = "anotationPin"
            pointAnnotation.coordinate = buildingAnnotaionArray[building]!
            pointAnnotation.title = building
            pinAnnotationView = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: "pin")
            map.addAnnotation(pinAnnotationView.annotation!)
        }
        allLocation()
    }
    
    //this function converts type CLLocationCoordinate2D to CLLocation type and stores in an array
    func allLocation(){
        for building in buildingAnnotaionArray.values{
            let locationLat = building.latitude
            let locationLong = building.longitude
            let location = CLLocation(latitude: locationLat, longitude: locationLong)
            buildingLocations.append(location)
        }
    }
    
    //this function returns the building name for the given location
    func buildingName(location:CLLocation) -> String{
        
        var returString = ""
        for (key,value) in buildingAnnotaionArray{
            let latitude = value.latitude
            let longitude = value.longitude
            if location.distanceFromLocation(CLLocation(latitude: latitude, longitude: longitude)) < 1.0{
                returString = key
            }
        }
        return returString
    }
    
    //this function reasonable for the annotaiton interface on the maps and shows the annotaion image
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
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    //this function displays alert message with appropriate message when it is invoked
    func displayMessage(message:String) {
        let alert = UIAlertController(title: "", message: message,
                                      preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title:"OK", style: .Default, handler: nil)
        alert.addAction(defaultAction)
        self.presentViewController(alert,animated:true, completion:nil)
    }
    
    //this function checks whether there are any warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

