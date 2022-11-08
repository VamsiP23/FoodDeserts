//
//  ViewController.swift
//  FoodDesertTake2
//
//  Created by Vamsi Putti on 2/18/22.
//

import UIKit
import MapKit

class ViewController: UIViewController {
  
    
    var coordinates : [CLLocation] = []
    var routeOverlay : MKOverlay?
    var stuff : [[String : Any]] = []
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapView.delegate = self
       // translateSomeHoes(data)
        //drawSomeBitches(routeData: coordinates)
        var overlays = parseGeoJSON()
       mapView.addOverlays(overlays)
        //var points = parseGeoJSONBanks()
        //mapView.addAnnotations(points)
        //var x = 0
        //for overlay in overlays {
        //    let temp = stuff[x]["County"] as? String
        //    let temp1 = stuff[x]["State"] as? String
        //    let tester = CountyInfo(title: "\(temp!), \(temp1!  ) " , coordinate: overlay.coordinate)
       //     x+=1
       //     mapView.addAnnotation(tester)
      //  }
        
       // let initialLocation = CLLocation(latitude: 27.884533, longitude: -83.409609)
       // mapView.centerToLocation(initialLocation)

    }
    
    func translate(_ data : [[Double]]) {
        
        for coord in data {
            let loc = CLLocation(latitude: coord[1], longitude: coord[0])
            coordinates.append(loc)
        }
    }
    
    func draw(routeData: [CLLocation]) {
        let coords = routeData.map {
            location -> CLLocationCoordinate2D in return location.coordinate
        }
        
        DispatchQueue.main.async {
            self.routeOverlay = MKPolygon(coordinates: coords, count: coords.count)
            self.mapView.addOverlay(self.routeOverlay!, level: .aboveRoads)
        }
    }
    
    func parseGeoJSON() -> [MKOverlay] {
        guard let url = Bundle.main.url(forResource: "Food_Access_USDA", withExtension: "geojson") else {
            fatalError("cant find")
        }
        
        var geoJson = [MKGeoJSONObject]()
        do {
            let data = try Data(contentsOf: url)
            geoJson = try MKGeoJSONDecoder().decode(data)
            
        } catch {
            fatalError("cant find2")
        }
        
        var overlays = [MKOverlay]()
        for item in geoJson {
            if let feature = item as? MKGeoJSONFeature {
                do {
                    let propertyData = feature.properties
                    let json = try JSONSerialization.jsonObject(with: propertyData!)
                    stuff.append((json as? [String : Any])!)
                }
                catch {
                    fatalError("LLO")
                }
               
                for geo in feature.geometry {
                    if let polygon = geo as? MKPolygon {
                        overlays.append(polygon)
                    }
                }
                
            }
        }
        return overlays
        
    }
    func parseGeoJSONBanks() -> [FoodBanks] {
        guard let url = Bundle.main.url(forResource: "PlEASEWORK", withExtension: "geojson") else {
            fatalError("cant find")
        }
        
        var geoJson = [MKGeoJSONObject]()
        do {
            let data = try Data(contentsOf: url)
            geoJson = try MKGeoJSONDecoder().decode(data)
            
        } catch {
            fatalError("cant find2")
        }
        
        var overlays = [FoodBanks]()
        for item in geoJson {
            if let feature = item as? MKGeoJSONFeature {
                do {
                    let propertyData = feature.properties
                    let json = try JSONSerialization.jsonObject(with: propertyData!)
                    stuff.append((json as? [String : Any])!)
                }
                catch {
                    fatalError("LLO")
                }
               var x = 0
                for geo in feature.geometry {
                    if let polygon = geo as? MKPointAnnotation {
                        let temp = FoodBanks(coordinate: geo.coordinate, title: stuff[x]["Name"] as! String, subtitle: "")
                        x+=1
                        overlays.append(temp)
                    }
                }
                
            }
        }
        return overlays
        
    }
    

}

extension ViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolygonRenderer(overlay: overlay)
        if overlay is MKPolygon {
        let renderer = MKPolygonRenderer(overlay: overlay)
            renderer.fillColor = UIColor.red.withAlphaComponent(0.5)
            renderer.strokeColor = UIColor.black
            renderer.lineWidth = 1.0
            
        return renderer
        }
        renderer.fillColor = UIColor.blue
        return renderer
    }
    func mapView(
      _ mapView: MKMapView,
      viewFor annotation: MKAnnotation
    ) -> MKAnnotationView? {
      let annotationView = FoodBanksView(
        annotation: annotation,
        reuseIdentifier: "Attraction")
      annotationView.canShowCallout = true
      return annotationView
    }

}


private extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000000) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
        
        
    }
}

