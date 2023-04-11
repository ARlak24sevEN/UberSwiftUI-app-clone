//
//  LocationSearchActivationView.swift
//  UberSwiftUI-app-clone
//
//  Created by Arlak Abdulloh on 11/4/2566 BE.
//

import SwiftUI

struct LocationSearchActivationView: View {
    var body: some View {
        HStack{
            Rectangle()
                .fill(Color.black)
                .frame(width: 8, height: 8)
                .padding(.horizontal)
            Text("Where to?")
                .foregroundColor(Color(.darkGray))
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width-64, height: 50)
        .background(
            Rectangle()
                .fill(.white)
                .shadow(color: .blue, radius: 6))
    }
}

struct LocationSearchActivationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchActivationView()
    }
}
