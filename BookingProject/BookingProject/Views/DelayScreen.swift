import SwiftUI

struct InformationDetailView: View {
    var title: String = "title"
    var subTitle: String = "subTitle"
    var imageName: String = "car"

    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: imageName)
                .font(.largeTitle)
                .foregroundColor(.indigo)
                .padding()
                .accessibility(hidden: true)

            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .accessibility(addTraits: .isHeader)

                Text(subTitle)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.top)
    }
}

struct InfoView: View {

    var backgroundColor: Color = Color.clear
    
    var body: some View {
        VStack(alignment: .leading) {
            InformationDetailView(title: "Match", subTitle: "Match the gradients by moving the Red, Green and Blue sliders for the left and right colors.", imageName: "slider.horizontal.below.rectangle")

            InformationDetailView(title: "Precise", subTitle: "More precision with the steppers to get that 100 score.", imageName: "minus.slash.plus")

            InformationDetailView(title: "Score", subTitle: "A detailed score and comparsion of your gradient and the target gradient.", imageName: "checkmark.square")
        }
        .background(backgroundColor)
        .padding(.horizontal)
    }
}

struct DelayScreen: View {
    
    @State var titleView: WelcomeTitleView = WelcomeTitleView()
    @State var infoView: InfoView = InfoView()

    @State private var hidden = false
        
    var body: some View {
        VStack(alignment: .center) {

            titleView
            infoView

            Spacer(minLength: 30)
            
            Button(action: {
                TableViewController.delayscreen?.dismiss(animated: true, completion: {
                    print("qweqweqwe")
                 })
            }) {
                Text("Continue")
                    .customButton()
            }
            .padding(.horizontal)
            Spacer()
        }
    }
}
 
struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.headline)
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.indigo))
            .padding(.bottom)
    }
}

extension View {
    func customButton() -> ModifiedContent<Self, ButtonModifier> {
        return modifier(ButtonModifier())
    }
}

extension Color { static var indigo = Color(UIColor.systemIndigo) }

struct DelayScreen_Previews: PreviewProvider {
    static var previews: some View {
        DelayScreen()
    }
}
