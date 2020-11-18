import SwiftUI

let hotels: [Hotel] = Handler.getdb()

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

struct MainCatalog_Previews: PreviewProvider {
    static var previews: some View {
        MainCatalog()
    }
}
