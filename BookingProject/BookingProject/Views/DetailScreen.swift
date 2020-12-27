import SwiftUI
import MapKit

struct DetailScreen : View {
    
    @State public var hotel: Hotel
    
    var body: some View {
        VStack(alignment: .center, spacing: nil, content: {
            Image(uiImage: hotel.image)
                .resizable()
                .padding(.top, 5)
                .cornerRadius(15.0)
                .aspectRatio(1.5, contentMode: .fit)
            
            if let lat = hotel.details?.lat,
               let lon = hotel.details?.lon {
                MKView(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), title: hotel.name, address: hotel.address)
                    .cornerRadius(15.0)
                    .aspectRatio(2, contentMode: .fit)
            }
            HStack(content: {
                Text("Available rooms: \(hotel.availableRooms)")
                    .padding(10)
                    .font(Font.title3.weight(.regular))
                Spacer()
                let stars = hotel.stars
                Text(String(repeating: "★", count: stars) + String(repeating: "☆", count: 5 - stars))
                    .lineLimit(1)
                    .foregroundColor(Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)))
                    .font(Font.title3.weight(.regular))
            }).padding(.horizontal, 5)
            Spacer()
            Text("Discount when booking through the app")
                .font(Font.callout.weight(.light))
            
            Button(action: {
                // POST REQUEST
                var body: [String:Any] = [:]
                body.updateValue("booking", forKey: hotel.name)
                API.shared.post(to: URLs.post, body: body)
            }) {
                // Label Button
                Text("Booking")
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(50.0)
            .scaleEffect(0.8)
            Spacer()
        })
        .padding([.horizontal,.bottom], 10)
        .navigationBarTitle(hotel.name, displayMode: .large)
    }
}

#if DEBUG
struct DetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        if let data = API.shared.get(from: URLs.get) {
            if let hotels: [Hotel] = Handler.codableArray(data) {
                DetailScreen(hotel: hotels[6])
                    .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                    .previewDisplayName("iPhone 8")
                
                DetailScreen(hotel: hotels[6])
                    .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
                    .previewDisplayName("iPhone 12 Pro Max")
            }
        }
    }
}
#endif
