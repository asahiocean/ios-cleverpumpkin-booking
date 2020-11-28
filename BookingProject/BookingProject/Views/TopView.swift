import SwiftUI

struct TopView : View {
    
    @State var hotel: Hotel
    
    var body: some View {
        HStack(spacing: 1.0) {
            Image(uiImage: UIImage(data: hotel.imagedata)!)
                .resizable()
                .frame(width: 100, height: 100)
                .aspectRatio(1, contentMode: .fit)
                .background(Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)))
                .padding(5)
            VStack(alignment: .leading, spacing: 10) {
                Text(hotel.address)
                    .font(.title)
                    .padding(.trailing, 10)
                HStack {
                    let dist = String(Int(hotel.distance * 10))
                    Text(dist + " м. от центра")
                    Spacer()
                    Text(String(hotel.stars))
                        .padding(.trailing, 10)
                }
            }
        }
    }
}

#if DEBUG
struct TopView_Previews : PreviewProvider {
    static var previews: some View {
        let data = API.shared.getData(url: URLs.get)
        if let hotels: [Hotel] = Handler.genericData(data) {
            TopView(hotel: hotels[0])
                .previewLayout(.sizeThatFits)
        }
    }
}
#endif
