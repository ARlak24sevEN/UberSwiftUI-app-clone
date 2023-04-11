//
//  LocationSearchResultCell.swift
//  UberSwiftUI-app-clone
//
//  Created by Arlak Abdulloh on 11/4/2566 BE.
//

import SwiftUI

struct LocationSearchResultCell: View {
    var body: some View {
        HStack{
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(.blue)
                .accentColor(.white)
                .frame(width: 40, height: 40)
            
            VStack(alignment:.leading,spacing: 4){
                Text("Starbuck Coffee")
                    .font(.body)
                
                Text("123 Main St' Cupertino CA")
                    .font(.system(size:15))
                    .foregroundColor(.gray)
                Divider()
            }
            .padding(.leading,8)
            .padding(.leading,8)
        }
        .padding(.leading)
    }
}

struct LocationSearchResultCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchResultCell()
    }
}