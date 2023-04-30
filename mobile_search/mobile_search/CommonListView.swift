//
//  CommonListView.swift
//  mobile_search
//
//  Created by HMY on 2023/4/22.
//

import SwiftUI
import Kingfisher

struct CommonListView: View {
    @StateObject var eventStore: EventStore
    @State var events: [Event] = []
    var fromFavourite = false
    var removeHandler: (IndexSet)->Void
    var body: some View {
        if (fromFavourite) {
            List {
                ForEach(eventStore.events) { result in
                    NavigationLink(destination: DetailView(eventStore: eventStore, event: result)) {
                        HStack{
                            Text(result.dates?.start?.dateTime ?? "")
                                .font(.system(size: 11))
                                .foregroundColor(Color.gray)
                                .padding(.trailing)
                            KFImage(URL(string: result.images?.first?.url ?? "")!).resizable()
                                .padding(.trailing)
                                .scaledToFill().frame(width: 30, height:30)
                            Text(result.name ?? "").font(.system(size: 11)).padding(.trailing)
                            Text(result.embedded?.venues?.first?.name ?? "").font(.system(size: 11))
                                .foregroundColor(Color.gray)
                        }.frame(height: 80)
                    }
                }.onDelete { index in
                    
                    eventStore.delete(event: index)
                }
            }
        } 
        
    }
}
