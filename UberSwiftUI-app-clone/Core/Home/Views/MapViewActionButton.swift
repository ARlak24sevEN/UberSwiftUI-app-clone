//
//  MapViewActionButton.swift
//  UberSwiftUI-app-clone
//
//  Created by Arlak Abdulloh on 11/4/2566 BE.
//

import SwiftUI

struct MapViewActionButton: View {
    @Binding var showLocatinSearchView: Bool
    var body: some View {
        Button{
            withAnimation(.spring()){
                showLocatinSearchView.toggle()
            }
            
        }label: {
            Image(systemName: showLocatinSearchView ? "arrow.left" : "line.3.horizontal")
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewActionButton(showLocatinSearchView: .constant(true))
    }
}
