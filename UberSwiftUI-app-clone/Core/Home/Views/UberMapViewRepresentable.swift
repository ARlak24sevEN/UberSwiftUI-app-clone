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
        
        //MARK: lifecycle
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        //MARK: mapviewDwelegate
        
        // update my location
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        
            parent.mapView.setRegion(region,animated: true)
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
    }
}
