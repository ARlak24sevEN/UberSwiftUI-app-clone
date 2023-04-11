//
//  HomeView.swift
//  UberSwiftUI-app-clone
//
//  Created by Arlak Abdulloh on 10/4/2566 BE.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack(alignment: .top) {
            UberMapViewRepresentable()
                .ignoresSafeArea()
            LocationSearchActivationView()
            .padding(.top, 72)
            
            MapViewActionButton()
                .padding(.leading)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
