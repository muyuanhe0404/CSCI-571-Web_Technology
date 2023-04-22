//
//  DetailView.swift
//  mobile_search
//
//  Created by HMY on 2023/4/17.
//

import SwiftUI

struct DetailView: View {
    var event: Event?
    var body: some View {
        TabView {
            EventsView().tabItem {
                Image(systemName: "1.square.fill")
                Text("Events")
            }
            Text("Events").tabItem {
                Image(systemName: "2.square.fill")
                Text("Artists/Team")
            }
            Text("Events").tabItem {
                Image(systemName: "3.square.fill")
                Text("Venue")
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
