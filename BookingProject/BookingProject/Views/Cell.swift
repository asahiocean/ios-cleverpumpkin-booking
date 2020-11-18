//
//  Cell.swift
//  BookingProject
//
//  Created by Sergey Fedotov on 17.11.2020.
//

import SwiftUI

struct Cell : View {
    
    var hotel: Hotel
    
    var body: some View {
        VStack(spacing: 16.0) {
            TopView(hotel: hotel)
        }.padding()
    }
}

struct Cell_Previews : PreviewProvider {
    static var previews: some View {
        Cell(hotel: Handler.getdb()[0])
            .previewLayout(.sizeThatFits)
    }
}
