import SwiftUI
import MapKit

struct MKView: UIViewRepresentable {
    
    @State var center: CLLocationCoordinate2D
    @State var title: String
    @State var address: String
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        let anno = MKPin(center, title: title, subtitle: address)
        mapView.addAnnotation(anno)
        
        mapView.setRegion(MKCoordinateRegion(center: center, latitudinalMeters: 300, longitudinalMeters: 300), animated: true)
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) { }
}
