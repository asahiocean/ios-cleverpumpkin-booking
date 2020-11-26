import SwiftUI

struct DetailScreen : View {
    
    @State internal var hotel: Hotel
    
    var body: some View {
        VStack(alignment: .center, spacing: 10, content: {
            Image(uiImage: hotel.image)
                .resizable()
                .padding()
                .border(Color.gray, width: 3)
                .aspectRatio(1.75, contentMode: .fit)
            VStack(alignment: .leading, spacing: 0, content: {
                Text("Описание").font(.title)
                Text(hotel.address)
                    .lineLimit(nil)
            })
            .ignoresSafeArea(.all)
            Spacer()
        }).navigationBarTitle(hotel.name, displayMode: .large)
    }
}

#if DEBUG
struct DetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        let data = API.shared.getData(url: URLs.get)
        if let _hotel: Hotel = Handler.genericData(data)?[0] {
            DetailScreen(hotel: _hotel)
                .previewLayout(.device)
        }
    }
}
#endif
