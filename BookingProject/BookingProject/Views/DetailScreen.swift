import SwiftUI
import MapKit

struct DetailScreen : View {
    
    @Binding public var hotel: Hotel
    
    struct Place: Identifiable {
        var id = UUID()
        let name: String
        let lat: Double
        let lon: Double
        
        var coord: CLLocationCoordinate2D {
            CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
    }
    
    struct MapViewWithAnnotations: View {
        let places = [
            Place(name: "Kozy Eats", lat: 56.951924, lon: 24.125584),
            Place(name: "Green Pumpkin", lat:  56.967520, lon: 24.105760),
            Place(name: "Terapija", lat: 56.9539906, lon: 24.13649290000000)
        ]
        
        @State var lat: Double?
        @State var lon: Double?
        
        @State var coordRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56.948889, longitude: 24.106389),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        
        var body: some View {
            Map(coordinateRegion: $coordRegion,
                annotationItems: places) { place in
            MapMarker(coordinate: place.coord, tint: .green)
            }.edgesIgnoringSafeArea(.all)
        }
    }
    
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
            //MapViewWithAnnotations(lat: hotel.lat, lon: hotel.lat)
            Spacer()
        })
        .scaleEffect(0.975)
        .navigationBarTitle(hotel.name, displayMode: .large)
    }
}

#if DEBUG
struct DetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        if let data = API.shared.load(from: URLs.get) {
            if let hotels: [Hotel] = Handler.codableArray(data) {
                DetailScreen(hotel: .constant(hotels[0])).previewLayout(.device)
            }
        }
    }
}
#endif
