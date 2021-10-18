//
//  MapsViewController.swift
//  Turkmen Afisha News
//
//  Created by izi on 25.07.2021.
//

import UIKit
import MapKit
import CoreLocation
import FloatingPanel

class MapsViewController: UIViewController, CLLocationManagerDelegate, FloatingPanelControllerDelegate  {
    
    @IBOutlet weak var mapView: MKMapView!
    var location: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting up floationg panel (place where addresses are shown)
        let fpc = FloatingPanelController()
        fpc.delegate = self
        let vc = storyboard?.instantiateViewController(withIdentifier: "floatingPanel") as? FloatingPanelViewController
        fpc.set (contentViewController : vc)
        fpc.addPanel(toParent: self)
        
        //setting up mapView
        mapsOfSelectedOfficial = parsingMapsString()
        mapsOfSelectedOfficial.forEach { (map) in
            let lat = map.lat
            let lng = map.lng
            location = CLLocation (latitude: CLLocationDegrees(Double (lat)!), longitude: CLLocationDegrees(Double (lng)!))
            findAndAddPins(location: location)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if selectedOfficial.maps == "[]" {
            showAlert(code: 100)
        } else {
            goToSelectedPin(selectedPin: selectedMap)
        }
    }
    
    func findAndAddPins (location: CLLocation) {
        let coordinate = CLLocationCoordinate2D (latitude: location.coordinate.latitude,
                                                 longitude: location.coordinate.longitude)
        let pin = MKPointAnnotation ()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
    }
    
    func goToSelectedPin (selectedPin: Int){
        let map = mapsOfSelectedOfficial[selectedPin]
        let location = CLLocation (latitude: CLLocationDegrees(Double (map.lat)!), longitude: CLLocationDegrees(Double (map.lng)!))
        let coordinate = CLLocationCoordinate2D (latitude: location.coordinate.latitude,
                                                 longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan (latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion (center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func parsingMapsString() -> [Map] {
        let jsonData = selectedOfficial.maps?.data(using: .utf8)
        //"[{\"title\":\"map\",\"lat\":\"37.954555\",\"lng\":\"58.379165\"}, {\"title\":\"map\",\"lat\":\"37.854555\",\"lng\":\"58.479165\"}]".data(using: .utf8)
        let jsonDecoder = JSONDecoder ()
        do {
            let maps = try jsonDecoder.decode([Map].self, from: jsonData!)
            return (maps)
        } catch {
            print ("Failed to decode \(error)")
        }
        return []
    }
}




class FloatingPanelViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "placesCell")
        myTableView.delegate = self
        myTableView.dataSource = self
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mapsOfSelectedOfficial.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placesCell", for: indexPath)
        cell.textLabel?.text = mapsOfSelectedOfficial[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let map = mapsOfSelectedOfficial[indexPath.row]
        let location = CLLocation (latitude: CLLocationDegrees(Double (map.lat)!), longitude: CLLocationDegrees(Double (map.lng)!))
//        let coordinate = CLLocationCoordinate2D (latitude: location.coordinate.latitude,
//                                                 longitude: location.coordinate.longitude)
        selectedMap = indexPath.row
        let vc = (storyboard?.instantiateViewController(withIdentifier: "mapVc"))
        
        navigationController?.pushViewController(vc!, animated: false)
        navigationController?.popViewController(animated: true)
        
        
    }
}


