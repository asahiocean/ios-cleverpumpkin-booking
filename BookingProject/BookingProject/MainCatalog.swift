//
//  MainCatalog.swift
//  BookingProject
//
//  Created by Sergey Fedotov on 17.11.2020.
//

import SwiftUI

let hotels: [Hotel] = Handler.getdb()

@available(iOS 14.0, *)
struct MainCatalog: View {
    
    var body: some View {
        NavigationView {
            List(hotels) { hotel in
                Cell(hotel: hotel)
            }
            .navigationTitle("Catalog")
        }
    }
}

@available(iOS 14.0, *)
struct MainCatalog_Previews: PreviewProvider {
    static var previews: some View {
        MainCatalog()
    }
}
