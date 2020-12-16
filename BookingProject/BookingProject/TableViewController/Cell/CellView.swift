import SwiftUI

struct Cell: View {
    
    @State var hotel: Hotel
    
    var body: some View {
        HStack(spacing: 1.0) {
            if let uiImage = hotel.image {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .aspectRatio(1, contentMode: .fit)
                    .background(Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)))
                    .padding(5)
            }
            VStack(alignment: .leading, spacing: 10) {
                Text(hotel.name)
                    .lineLimit(1)
                    .font(.custom("Andale Mono", size: 30))
                    .padding(.trailing, 10)
                Text(hotel.address)
                    .font(.subheadline)
                    .padding(.trailing, 10)
                HStack {
                    let dist = String(Int(hotel.distance * 10))
                    Text(dist + " м. от центра")
                        .font(.subheadline)
                    Spacer()
                    let stars = hotel.stars
                    Text(
                        String(repeating: "⭑", count: stars) +
                        String(repeating: "✩", count: 5 - stars)
                    ).padding(.trailing, 10)
                }
            }
        }
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        if let data = API.shared.loadData(from: URLs.get),
           let hotels: [Hotel] = Handler.genericData(data) {
            Cell(hotel: hotels[0]).previewLayout(.sizeThatFits)
        }
    }
}
