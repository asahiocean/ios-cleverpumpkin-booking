import SwiftUI

struct BadgeBackground: View {
    
    struct HexagonParameters {
        struct Segment {
            let line: CGPoint
            let curve: CGPoint
            let control: CGPoint
        }
        
        static let segments = [
            Segment(
                line:    CGPoint(x: 0.6, y: 0.05),
                curve:   CGPoint(x: 0.4, y: 0.05),
                control: CGPoint(x: 0.5, y: 0.0)
            ),
            Segment(
                line:    CGPoint(x: 0.05, y: 0.2),
                curve:   CGPoint(x: 0.0, y: 0.3),
                control: CGPoint(x: 0.0, y: 0.25)
            ),
            Segment(
                line:    CGPoint(x: 0.0, y: 0.7),
                curve:   CGPoint(x: 0.05, y: 0.8),
                control: CGPoint(x: 0.0, y: 0.75)
            ),
            Segment(
                line:    CGPoint(x: 0.4, y: 0.95),
                curve:   CGPoint(x: 0.6, y: 0.95),
                control: CGPoint(x: 0.5, y: 1.0)
            ),
            Segment(
                line:    CGPoint(x: 0.9, y: 0.8),
                curve:   CGPoint(x: 1.0, y: 0.7),
                control: CGPoint(x: 1.0, y: 0.75)
            ),
            Segment(
                line:    CGPoint(x: 1.0, y: 0.3),
                curve:   CGPoint(x: 0.95, y: 0.2),
                control: CGPoint(x: 1.0, y: 0.25)
            )
        ]
    }
    
    var body: some View {
        GeometryReader { geo in
            Path { path in
                var w: CGFloat = min(geo.size.width, geo.size.height)
                let h = w
                let s: CGFloat = 0.2 // scale
                let o = (w * (1 - s))/2 // offset
                w *= s
                path.move(to: CGPoint(x: w * 0.95 + o, y: h * (0.2)))
                
                HexagonParameters.segments.forEach { segm in
                    path.addLine(to: CGPoint(
                        x: w * segm.line.x + o,
                        y: h * segm.line.y
                    )
                    )
                    path.addQuadCurve(to: CGPoint(
                        x: w * segm.curve.x + o,
                        y: h * segm.curve.y
                    ),
                    control: CGPoint(
                        x: w * segm.control.x + o,
                        y: h * segm.control.y
                    )
                    )
                }
            }
            .fill(LinearGradient(
                gradient: Gradient(
                    colors: [
                        Color(#colorLiteral(red: 0.9334935546, green: 0, blue: 0.6870797276, alpha: 1)),
                        Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
                    ]),
                startPoint: UnitPoint(x: 1, y: 0.3),
                endPoint: UnitPoint(x: 1, y: 0.7)
            ))
        }
        .shadow(radius: 10)
    }
}

struct RotatedBadgeSymbol: View {
    let angle: Angle
    
    var body: some View {
        GeometryReader { geo in
            Path { path in
                let w = min(geo.size.width, geo.size.height)
                let h = w * 0.75 // height
                let s = w * 0.03 // spacing
                let m = w * 0.5 // middle
                let tw = w * 0.25 // topWidth
                let th = h * 0.5 // topHeight
                
                path.addLines([
                    CGPoint(x: m, y: s),
                    CGPoint(x: m - tw, y: th - s),
                    CGPoint(x: m, y: th / 2 + s),
                    CGPoint(x: m + tw, y: th - s),
                    CGPoint(x: m, y: s)
                ])
                path.addLines([
                    CGPoint(x: m - tw, y: th + s),
                    CGPoint(x: s, y: h - s),
                    CGPoint(x: w - s, y: h - s),
                    CGPoint(x: m + tw, y: th + s),
                    CGPoint(x: m, y: th / 2 + s * 3)
                ])
            }
        }
        .padding(-50)
        .rotationEffect(angle, anchor: .bottom)
    }
}

struct Badge: View {
    private static let count: Double = 8.0
    
    var badge: some View {
        ForEach(0..<Int(Self.count)) { i in
            RotatedBadgeSymbol(
                angle: .degrees(Double(i) / Self.count * 360.0
                ))
        }
        .opacity(0.5)
    }
    
    var body: some View {
        ZStack {
            BadgeBackground()
            GeometryReader { geo in
                badge
                    .scaleEffect(1/4, anchor: .top)
                    .position(
                        x: geo.size.width/2,
                        y: (3/4) * geo.size.height)
            }
        }
        .scaledToFit()
    }
}

struct DelayScreen: View {
    
    @State private var degrees = 0.0
    private let animation: Animation = Animation
        .easeInOut(duration: 1.0)
        .repeatForever(autoreverses: false)
    
    var body: some View {
        Badge()
            .scaleEffect(0.5)
            .rotationEffect(.degrees(degrees))
            .onAppear() {
                withAnimation(animation) { degrees = 360 }
            }
    }
}


#if DEBUG
struct DelayScreen_Previews: PreviewProvider {
    static var previews: some View {
        DelayScreen().previewLayout(.device)
    }
}
#endif
