import SwiftUI

struct DetailScreen : View {
    
    @Binding public var hotel: Hotel
    
    var body: some View {
        VStack(alignment: .center, spacing: 10, content: {
            Image(uiImage: hotel.image)
                .resizable()
                .scaledToFit()
            VStack(alignment: .leading, spacing: 0, content: {
                Text("Описание")
                    .font(.title)
                Text(hotel.address)
                    .lineLimit(nil)
            }).ignoresSafeArea(.all)
            Spacer()
        }).navigationBarTitle(hotel.name, displayMode: .large)
    }
}

#if DEBUG
struct DetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        if let data = API.shared.loadData(from: URLs.get) {
            if let hotels: [Hotel] = Handler.genericData(data) {
                DetailScreen(hotel: .constant(hotels[0])).previewLayout(.device)
            }
        }
    }
}
#endif
