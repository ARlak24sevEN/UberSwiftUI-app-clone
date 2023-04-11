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
    @Published var selectedLocation :String?
    
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
    func selecteLocation(_ location: String){
        self.selectedLocation = location
//        print("Debug: Selected location is \(self.selectedLocation)")
    }
}

//MARK: = MKLocalSearchCompleterDelegate
extension LocationSearchViewModel: MKLocalSearchCompleterDelegate{
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
