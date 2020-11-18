import SwiftUI

struct TopView : View {
    
    var hotel: Hotel
    
    var body: some View {
        HStack(spacing: 8.0) {
            
            Image(uiImage: hotel.image)
                .resizable()
                .frame(width: 70, height: 70)
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 4.0) {
                Text(hotel.address)
                    .font(.title)
                HStack {
                    // "\(String(describing: Int(model.distance)))m from city center"
                    Text("\(String(hotel.distance)) м. от центра")
                    .font(.subheadline)

                    Spacer()
                    Image("like")
                    Text(LocalizedStringKey(String(hotel.stars)))
                        .font(.subheadline)
                }
            }
        }
    }
}

#if DEBUG
struct TopView_Previews : PreviewProvider {
    static var previews: some View {
        TopView(hotel: Handler.getdb()[2])
            .previewLayout(.sizeThatFits)
    }
}
#endif
