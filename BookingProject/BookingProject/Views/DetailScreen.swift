import SwiftUI

struct DetailScreen : View {
    
    var object: Hotel
    
    var body: some View {
        VStack(spacing: 16.0) {
            VStack(spacing: 20.0) {
                MainImage(object: object)
                Text(object.name)
                    .lineLimit(nil)
                    .font(.title)
            }
            VStack(alignment: .leading, spacing: 12.0) {
                Text("Описание")
                    .font(.title)
                Text(object.address)
                    .lineLimit(nil)
            }
            Spacer()
            }.padding()
    }
}

struct MainImage: View {
    
    var object: Hotel
    
    var body: some View {
        Image(uiImage: .actions)
            .resizable()
            .cornerRadius(30)
            .frame(width: 170, height: 170)
            .border(Color.gray, width: 3)
            .shadow(radius: 10)
    }
}


