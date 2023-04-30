//
//  MapView.swift
//  mobile_search
//
//  Created by HMY on 2023/4/21.
//

import SwiftUI
import CoreLocation
import MapKit
struct Marker: Identifiable {
    let id = UUID()
    var location: MapMarker
}

struct MapView: View {
    var latitude: Double?
    var longtitude: Double?
    @State var region:MKCoordinateRegion = MKCoordinateRegion()
    
    var markers:[Marker]?

    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: markers ?? []) { marker in
            marker.location
        }
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
