//
//  LocationSearchView.swift
//  UberSwiftUI-app-clone
//
//  Created by Arlak Abdulloh on 11/4/2566 BE.
//

import SwiftUI

struct LocationSearchView: View {
    @State private var startLocationText = ""
    @State private var detinationLocationText = ""
    var body: some View {
        VStack{
        // header view
            HStack{
                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                    .frame(width: 6, height: 6)
                    
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 24)
                    
                    Circle()
                        .fill(.black)
                        .frame(width: 6, height: 6)
                }
                
                VStack{
                    TextField("Current Loacation", text: $startLocationText)
                        .frame(height: 32)
                        .background(Color(
                            .systemGroupedBackground))
                        .padding(.trailing)
                    TextField("Where to?", text: $detinationLocationText)
                        .frame(height: 32)
                        .background(Color(
                            .systemGray4))
                        .padding(.trailing)
                }
               
            }
            .padding(.horizontal)
            .padding(.top,64)
            Divider()
                .padding(.vertical )
            
            //list view
            ScrollView{
                VStack{
                    ForEach(0..<20, id: \.self){_ in
                       LocationSearchResultCell()
                    }
                }
               
            }
        }
        .background(.white )
        
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView()
    }
}
