import SwiftUI

struct InformationDetailView: View {
    var title: String = "Lorem ipsum"
    var subTitle: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua..."
    var imageName: String = "aqi.low"

    var body: some View {
        HStack(alignment: .center, spacing: 0, content: {
            Image(systemName: imageName)
                .font(.largeTitle)
                .foregroundColor(.indigo)
                .padding(.all, 10)

            VStack(alignment: .leading, spacing: 0, content: {
                Text(title)
                    .lineLimit(1)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .accessibility(addTraits: .isHeader)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 5)
                
                Text(subTitle)
                    .lineLimit(nil)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.trailing, 5)
                
            })
            .frame(maxWidth: .infinity, alignment: .leading)
        })
        .padding([.top,.bottom])
    }
}

struct InformationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        InformationDetailView()
            .previewLayout(.sizeThatFits)
    }
}
