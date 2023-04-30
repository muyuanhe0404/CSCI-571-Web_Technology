//
//  VenueView.swift
//  mobile_search
//
//  Created by HMY on 2023/4/21.
//

import SwiftUI
import CoreLocation
import MapKit

struct VenueView: View {
    var venue: Venue? = nil
    var title: String? = nil
    var body: some View {
        var lat = Double(venue?.location?.latitude ?? "0") ?? 0.0
        var lot = Double(venue?.location?.longitude ?? "0") ?? 0.0
        var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lot), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        var markers = [Marker(location: MapMarker(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lot), tint: .red))]
        VStack {
            Text(title ?? "").font(.title)
            getView1()
            getView()
            NavigationLink(destination: MapView(latitude: lat, longtitude: lot, region: region, markers: markers), label:{Text("Show venue on maps")})
            Spacer()
        }
    }
    func getView1() -> some View {
        return Group {
            Text("Name")
            Text("\(venue?.name ?? "")").padding(.bottom).foregroundColor(Color.gray)
            Text("Address")
            Text("\(venue?.address?.line1 ?? "")").padding(.bottom).foregroundColor(Color.gray)
            Text("Phone Number")
            Text("\(venue?.boxOfficeInfo?.phoneNumberDetail ?? "no phone number")").padding(.bottom).foregroundColor(Color.gray)
        }
    }
    
    func getView() -> some View {
        return Group {
            Text("Open Hours")
            Text("\(venue?.boxOfficeInfo?.openHoursDetail ?? "no open hour detail available")").padding(.bottom).foregroundColor(Color.gray)
            Text("General Rule")
            ScrollView {
                Text("\(venue?.generalInfo?.generalRule ?? "no general rule")").foregroundColor(Color.gray)
            }.padding(.bottom).frame(height: 100)
            Text("Child Rule")
            ScrollView {
                Text("\(venue?.generalInfo?.childRule ?? "no child rule")").foregroundColor(Color.gray)
            }.padding(.bottom).frame(height: 100)
        }
    }
}

struct VenueView_Previews: PreviewProvider {
    static var previews: some View {
        VenueView()
    }
}
