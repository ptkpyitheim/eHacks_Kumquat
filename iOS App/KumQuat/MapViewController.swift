//
//  ViewController.swift
//  Final
//
//  learn from: https://www.youtube.com/watch?v=ACAROimc8jA
//  learn from: https://www.youtube.com/watch?v=8m-duJ9X_Hs


import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    @IBOutlet weak var latitudeText: UITextField!
    
    @IBOutlet weak var longitudeText: UITextField!
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBOutlet weak var theSwitch: UISwitch!
    
    var pinPointUserloaction = false
    var steps = [MKRouteStep]()
    
   
    @objc func dismissKeyBoard() {
        view.endEditing(true)
    }
    func clearMap() {
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
    }
    
    @IBAction func navigationButton(_ sender: Any) {
        dismissKeyBoard()
        if let latitude = latitudeText.text, let longitude = longitudeText.text{
            if ((latitude) != "") && (longitude != "") {
                if let lat = Double(latitude), let lon = Double(longitude){
                    self.clearMap()
                    let coor = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
                    //                    print("the coor is \(coor)")
                    let detinationAddress = PointOfInterest(title: "detination", locationName: "Famous Place 3", coordinate: coor)
                    mapView.addAnnotation(detinationAddress)
                    
                    let directionRequest = MKDirectionsRequest()
                    directionRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: mapView.userLocation.coordinate))
                    //                    print("the source is \(directionRequest.source)")
                    directionRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: coor))
                    directionRequest.requestsAlternateRoutes = false
                    directionRequest.transportType = .automobile
                    
                    
                    let directions = MKDirections(request: directionRequest)
                    directions.calculate { (response, _) in
                        guard let resonse = response else {return}
                        guard let primaryRoute = response?.routes.first else {return}
                        self.mapView.add(primaryRoute.polyline)
                        self.steps = primaryRoute.steps
                    }
                    
                }
                
            }
        }
    }
    
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if pinPointUserloaction == false {
            print("user location")
            mapView.region.center = mapView.userLocation.coordinate
            pinPointUserloaction = true
        }
    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline{
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .red
            renderer.lineWidth = 6.0
            return renderer
        }
        return MKOverlayRenderer()
    }
    
    
    
    
   
    @IBAction func switchMoved(_ sender: Any) {
        if(theSwitch.isOn) {
            mapView.mapType = .satellite
        }else{
            mapView.mapType = .hybrid
        }
    }
    
    
    
    @IBAction func addStuff(_ sender: Any) {
        
        let somePoint1 = PointOfInterest(title: "Some Place 1", locationName: "Famous Place", coordinate: CLLocationCoordinate2DMake(33.0, -125.0))
        
        mapView.addAnnotation(somePoint1)
        
        let somePoint2 = PointOfInterest(title: "Some Place 2", locationName: "Famous Place 2", coordinate: CLLocationCoordinate2DMake(40.0, -122.294748))
        
        mapView.addAnnotation(somePoint2)
        
    }
    
    //    ---------------/--------------------/----------------------------------
    
    
    
    
    
    //    ---------------/--------------------/----------------------------------
    let locationManager = CLLocationManager()
    
    //    ---------------/--------------------/----------------------------------
    
    
    
    @objc func dropAnnotation(gestureRecogniser:UILongPressGestureRecognizer){
        if gestureRecogniser.state == .began{
            let holdLocation = gestureRecogniser.location(in: mapView )
            
            let coor = mapView.convert(holdLocation, toCoordinateFrom: mapView)
            
            let detinationAddress1 = PointOfInterest(title: "detination", locationName: "Famous Place 3", coordinate: coor)
            mapView.addAnnotation(detinationAddress1)
            
            latitudeText.text = "\(coor.latitude)"
            longitudeText.text = "\(coor.longitude)"
            
        }
        
    }
    //    ---------------/--------------------/----------------------------------
    
    
    
    
    
    //    viewdidload
    //    ---------------/--------------------/----------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(mapView)
        
        let keyboardDisappear = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyBoard))
        view.addGestureRecognizer(keyboardDisappear)
        
        let pinDropper = UILongPressGestureRecognizer(target: self, action: #selector(self.dropAnnotation(gestureRecogniser:)))
        pinDropper.minimumPressDuration = CFTimeInterval(2.0)
        view.addGestureRecognizer(pinDropper)
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    //    ---------------/--------------------/----------------------------------
    
    
    
    
    
    
    
    
    //    locationmanager
    //    ---------------/--------------------/----------------------------------
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let someLocation = locations[0]
        mapView.userTrackingMode = .followWithHeading //手机头朝向
        print("A single location is \(someLocation)")
        
        
        let howRecent = someLocation.timestamp.timeIntervalSinceNow
        
        if (howRecent < -10) { return }
        
        let accuracy = someLocation.horizontalAccuracy
        print("How recent is it? It is \(howRecent) and this level of accuracy \(accuracy) in meters")
        
    }
    
    
    
    
}









