//
//  UberMapViewRepresentable.swift
//  UberSwiftUI-app-clone
//
//  Created by Arlak Abdulloh on 10/4/2566 BE.
//

import SwiftUI
import MapKit

struct UberMapViewRepresentable: UIViewRepresentable{
    let mapView = MKMapView()
    let locatinManager = LocationManager()
    @EnvironmentObject var locationViewModel : LocationSearchViewModel
    
    
    // screen of map view
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let coordinate = locationViewModel.selectedLocationCoordinate{
//            print("Debug: selected coordinates is \(coordinate)")
            context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate )
            context.coordinator.configurePolyline(withDestinationCoordinate: coordinate)
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }

}

extension UberMapViewRepresentable{
    // set about map like permission protocal
    class MapCoordinator: NSObject, MKMapViewDelegate{
        let parent: UberMapViewRepresentable
        var userLocationCoordinate : CLLocationCoordinate2D?

        
        //MARK: lifecycle
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        //MARK: mapviewDwelegate
        
        // update my location
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        
            parent.mapView.setRegion(region,animated: true)
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) ->
            MKOverlayRenderer{
                let polyline = MKPolylineRenderer(overlay: overlay)
                polyline.strokeColor = .systemBlue
                polyline.lineWidth = 6
                
                return polyline
            }
        
        //MARK: Helper
        
        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D){
           
            //remove anotation mapview before add new anotaatin mapview
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            parent.mapView.addAnnotation(anno)
            parent.mapView.selectAnnotation(anno, animated: true)
            
            //zoom in nad zoom out fit for anotation
            parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
        
        // config poly line
        func configurePolyline(withDestinationCoordinate coordinate: CLLocationCoordinate2D){
            guard let userLocationCoordinate = self.userLocationCoordinate else {return}
                    
                    getDestinationRoute(from: userLocationCoordinate, to: coordinate){ route in
                        self.parent.mapView.addOverlay(route.polyline)
                    }
        }
        
        //route
        func getDestinationRoute(from userLocation: CLLocationCoordinate2D, to destination:CLLocationCoordinate2D,completion: @escaping(MKRoute)->Void){
             
            let userPlaceMark = MKPlacemark(coordinate: userLocation)
            let destPlaceMark = MKPlacemark(coordinate: destination)
            
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: userPlaceMark)
            request.destination = MKMapItem(placemark: destPlaceMark)
            
            let directions = MKDirections(request: request)
            
            directions.calculate{response , error in
                if let error = error {
                    print("DEBUG: Failed to get direction with error \(error)")
                    return
                }
                
                guard let route = response?.routes.first else {return}
                completion(route)
            }
        }
    }
}
