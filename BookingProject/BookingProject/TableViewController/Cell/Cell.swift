import SwiftUI

struct Cell: View {
    
    @State public var hotel: Hotel
    
    public var body: some View {
        // alignment: .center, spacing: 5.0, content: {
        HStack(spacing: nil, content: {
            if let uiImage = hotel.image {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(maxWidth: TableConfig.rowHeight,
                           maxHeight: TableConfig.rowHeight,
                           alignment: .center)
                    .aspectRatio(1, contentMode: .fill)
                    .padding([.top,.bottom], -5)
                    .clipped()
            }
            // alignment: .leading, spacing: 5.0, content: {
            VStack(spacing: 0, content: {
                Text(hotel.name)
                    .font(.title)
                    .fontWeight(.regular)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                
                Text(hotel.address)
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                
                //MARK: Distance + stars
                HStack(alignment: .bottom, spacing: 0, content: {
                    let distance = String(Int(hotel.distance))
                    Text(distance + " м. от центра")
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                        .font(.callout)
                    Spacer(minLength: 0)
                    let stars = hotel.stars
                    Text(
                        String(repeating: "⭑", count: stars) +
                        String(repeating: "✩", count: 5 - stars)
                    )
                    .lineLimit(1)
                    .foregroundColor(.yellow)
                    .multilineTextAlignment(.center)
                    .font(.headline)
                })
                .padding(.bottom, 5)
            })
        })
        .padding([.leading,.trailing], 5)
        .edgesIgnoringSafeArea(.all)
    }
}
#if DEBUG
struct Cell_Previews: PreviewProvider {
    static var previews: some View {
        if let data = API.shared.loadData(from: URLs.get),
           let hotels: [Hotel] = Handler.genericData(data) {
            Group {
                Cell(hotel: hotels[0])
                    .previewDevice("iPhone 8")
                    .previewDisplayName("iPhone 8")
                Cell(hotel: hotels[0])
                    .previewDevice("iPhone 12 Pro Max")
                    .previewDisplayName("iPhone 12 PM Dark Mode")
                    .background(Color(.systemBackground))
                    .environment(\.colorScheme, .dark)
            }
            .edgesIgnoringSafeArea(.all)
            .previewLayout(.fixed(width: TableConfig.width,
                                   height: TableConfig.rowHeight))
        }
    }
}
#endif
