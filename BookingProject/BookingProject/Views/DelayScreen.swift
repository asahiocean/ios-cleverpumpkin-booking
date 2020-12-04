import SwiftUI

struct DelayScreen: View {
    
    @State private var titleView: WelcomeTitleView = WelcomeTitleView()
    @State private var infoView: InfoView = InfoView()

    @State private var hidden = false
        
    var body: some View {
        VStack(alignment: .center, spacing: 0, content: {
            Spacer()
            self.titleView //MARK: WelcomeTitleView
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 20)
            self.infoView //MARK: InfoView
            Button(action: {
                TableViewController.delayscreen?.dismiss(animated: true, completion: {
                    print("qweqweqwe")
                 })
            }) {
                Text("Continue")
                    .padding()
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(RoundedRectangle(
                            cornerRadius: 15,
                            style: .circular)
                    .fill(Color.indigo))
                    .padding([.leading,.trailing], 50)
            }
            .padding(.vertical, 50)
            Spacer()
            Spacer()
        })
    }
}


#if DEBUG
struct DelayScreen_Previews: PreviewProvider {
    static var previews: some View {
        DelayScreen()
            .previewLayout(.device)
    }
}
#endif
