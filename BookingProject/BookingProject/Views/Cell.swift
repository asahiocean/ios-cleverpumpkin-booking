import SwiftUI

struct Cell : View {
    
    @State var hotel: Hotel
    
    var body: some View {
        TopView(hotel: hotel)
    }
}

#if DEBUG
struct Cell_Previews : PreviewProvider {
    static var previews: some View {
        let data = API.shared.getData(url: URLs.get)
        if let hotels: [Hotel] = Handler.genericData(data) {
            Cell(hotel: hotels[0])
                .previewLayout(.sizeThatFits)
        }
    }
}
#endif
