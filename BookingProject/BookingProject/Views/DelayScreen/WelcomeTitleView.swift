import SwiftUI

public var appname: String = "Booking"

struct WelcomeTitleView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0, content: {
            Text("Welcome to")
                .fontWeight(.black)
                .font(.system(size: 34))
            Text(appname)
                .fontWeight(.black)
                .font(.system(size: 36))
                .foregroundColor(.indigo)
        })
    }
}
