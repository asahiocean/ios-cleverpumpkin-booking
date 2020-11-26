import SwiftUI

struct MainCatalog: View {

    @State fileprivate var hotels: [Hotel]!
    
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
