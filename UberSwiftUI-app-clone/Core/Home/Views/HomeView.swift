//
//  HomeView.swift
//  UberSwiftUI-app-clone
//
//  Created by Arlak Abdulloh on 10/4/2566 BE.
//

import SwiftUI

struct HomeView: View {
    @State private var showLocationSearchView = false
    var body: some View {
        ZStack(alignment: .top) {
            UberMapViewRepresentable()
                .ignoresSafeArea()
            if showLocationSearchView{
                LocationSearchView(showlocationSearchView: $showLocationSearchView)
            }else{
                LocationSearchActivationView()
                .padding(.top, 72)
                .onTapGesture {
                    withAnimation(.spring()){
                        showLocationSearchView.toggle()
                    }
                }
            }
           
            
            MapViewActionButton(showLocatinSearchView: $showLocationSearchView)
                .padding(.leading)
                .padding(.top, 4)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
