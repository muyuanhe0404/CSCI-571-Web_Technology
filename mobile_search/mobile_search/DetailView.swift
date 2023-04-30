//
//  DetailView.swift
//  mobile_search
//
//  Created by HMY on 2023/4/17.
//

import SwiftUI

struct DetailView: View {
    @StateObject var eventStore: EventStore
    var event: Event?
    var body: some View {
        TabView {
            EventsView(eventStore: eventStore, detailStore: DetailStore(id: event!.id ?? ""), event: event!).tabItem {
                Image(systemName: "note.text")
                Text("Events")
            }
            ArtistView(event: event).tabItem {
                Image(systemName: "guitars")
                Text("Artists/Team")
            }
            VenueView(venue: event?.embedded?.venues?.first, title: event?.name).tabItem {
                Image(systemName: "location.fill")
                Text("Venue")
            }
        }
    }
}
