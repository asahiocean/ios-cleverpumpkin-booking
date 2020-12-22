import SwiftUI

struct Cell: View {
    
    @State public var hotel: Hotel
        
    public var body: some View {
        // alignment: .center, spacing: 5.0, content: {
        HStack(alignment: .center, spacing: 0.0, content: {
            if let uiImage = hotel.image {
                ZStack(alignment: .topLeading, content: {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(maxWidth: TableConfig.rowHeight,
                               maxHeight: TableConfig.rowHeight,
                               alignment: .center)
                        .aspectRatio(1.5, contentMode: .fill)
                        .padding([.top,.bottom], -5)
                        .clipped(antialiased: true)
                })
            }
            // alignment: .leading, spacing: 5.0, content: {
            VStack(spacing: 0, content: {
                Text(hotel.name)
                    .font(Font.title2.weight(.semibold))
                    .fontWeight(.regular)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                
                Text(hotel.address)
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)

                HStack(alignment: .center, spacing: 10, content: {
                    let distance = String(Int(hotel.distance))
                    Text(distance + "m. from city center")
                        .lineLimit(1)
                        .font(Font.footnote.weight(.light))
                    Spacer()
                    HStack(alignment: .center, spacing: 5, content: {
                        ZStack {
                           Circle()
                                .foregroundColor(Color(#colorLiteral(red: 0.5326635242, green: 0.8077927232, blue: 0.9814575315, alpha: 0.7)))
                                .scaleEffect(1.75)
                            Text("\(hotel.availableRooms)")
                                .font(Font.subheadline.weight(.regular))
                                .foregroundColor(.black)
                        }
                        .scaledToFit()
                        .padding(.trailing, 5)
                        
                        Text(String(repeating: "★", count: hotel.stars) + String(repeating: "☆", count: 5 - hotel.stars))
                            .lineLimit(1)
                            .font(Font.headline.weight(.bold))
                            .foregroundColor(Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)))
                    })
                }).padding(.bottom, 5)
            }).padding(.leading, 5)
        })
        .padding([.leading,.trailing], 5)
        .edgesIgnoringSafeArea(.all)
    }
}
#if DEBUG
struct Cell_Previews: PreviewProvider {
    static var previews: some View {
        if let data = API.shared.get(from: URLs.get),
           let hotels: [Hotel] = Handler.codableArray(data) {
            Group {
                Cell(hotel: hotels[2])
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
