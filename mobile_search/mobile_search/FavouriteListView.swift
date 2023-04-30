//
//  FavouriteListView.swift
//  mobile_search
//
//  Created by HMY on 2023/4/22.
//

import SwiftUI

struct FavouriteListView: View {
    @StateObject var eventStore:EventStore
    var body: some View {
        if (eventStore.events.isEmpty) {
            Text("No favourites found").foregroundColor(.red)
        } else {
            CommonListView(eventStore: eventStore, events: eventStore.events, fromFavourite: true) { e in
                eventStore.delete(event: e)
            }.navigationTitle("Favourites")
        }
    }
}
