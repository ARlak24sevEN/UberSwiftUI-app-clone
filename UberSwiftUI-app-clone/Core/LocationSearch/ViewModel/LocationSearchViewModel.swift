//
//  LocationSearchViewModel.swift
//  UberSwiftUI-app-clone
//
//  Created by Arlak Abdulloh on 11/4/2566 BE.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject{
    //MARK: Properties
    
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedLocationCoordinate : CLLocationCoordinate2D?
    
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment: String = ""{
        didSet{
//            print("Debug: Query fragment is \(queryFragment)")
            searchCompleter.queryFragment = queryFragment
        }
    }
    //MARK: lifecycle
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    //MARK: helper
    func selecteLocation(_ localSearch: MKLocalSearchCompletion){
//        self.selectedLocation = location
//        print("Debug: Selected location is \(self.selectedLocation)")
        locationSearch(forLocalSearchCompletion: localSearch){response, error in
            if let error = error{
                print("Debug : location search failed with error \(error.localizedDescription)")
                return
            }
            guard let item = response?.mapItems.first else{return}
            let coordinate = item.placemark.coordinate
            self.selectedLocationCoordinate = coordinate
            print("Debug: location coordinates \(coordinate)")
        }
    }
    
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler){
        let searchRequest = MKLocalSearch.Request()
        
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        
        let search = MKLocalSearch(request: searchRequest)
       
        search.start(completionHandler: completion)
    }
}

//MARK: = MKLocalSearchCompleterDelegate
extension LocationSearchViewModel: MKLocalSearchCompleterDelegate{
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
