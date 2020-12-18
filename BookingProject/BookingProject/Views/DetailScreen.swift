import SwiftUI

struct DetailScreen : View {
    
    @Binding public var hotel: Hotel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10, content: {
            Image(uiImage: hotel.image)
                .resizable()
                .scaledToFit()
                .cornerRadius(15.0, antialiased: true)
            HStack(spacing: 10, content: {
                Text("Rating:")
                Text(String(repeating: "⭑", count: hotel.stars) + String(repeating: "✩", count: 5 - hotel.stars))
                    .lineLimit(1)
                    .font(Font.title2)
                    .foregroundColor(Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)))
                    .padding(.bottom, 5)
                    .padding(.trailing, 10)
            })
            HStack(spacing: 10, content: {
                Text("Available rooms:")
                Text("\(hotel.availableRooms)")
                    .font(Font.body.weight(.semibold))
            })
            HStack(spacing: 10, content: {
                Text("Address:")
                Text(hotel.address)
                    .lineLimit(1)
                    .font(Font.body.weight(.semibold))
            })
            Spacer()
        })
        .scaleEffect(0.975)
        .navigationBarTitle(hotel.name, displayMode: .large)
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
