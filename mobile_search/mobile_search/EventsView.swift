//
//  EventsView.swift
//  mobile_search
//
//  Created by HMY on 2023/4/17.
//

import SwiftUI
import Kingfisher

struct EventsView: View {
    @StateObject var eventStore: EventStore
    @StateObject var detailStore: DetailStore
    @State var showToast: Bool = false
    @State var isAdd: Bool = false
    var event: Event? = nil
    var body: some View {
        if let event = detailStore.detail {
            VStack() {
                generateView1()
                generateView2()
                Group {
                    Text("Buy Ticket At: ")
                    Link("Ticketmaster", destination: URL(string: event.url ?? "")!)
                    
                    HStack {
                        Text("Share on: ")
                        Button {
                            UIApplication.shared.openURL(URL(string: "https://twitter.com/intent/tweet?url=\(event.url ?? "")")!)
                        } label: {
                            Image("twitter").resizable().frame(width: 20, height: 20)
                        }
                        Button {
                            UIApplication.shared.openURL( URL(string: "https://www.facebook.com/sharer/sharer.php?u=\(event.url ?? "")&src=sdkpreparse")!)
                        } label: {
                            Image("facebook").resizable().frame(width: 20, height: 20)
                        }
                    }
                }
                Spacer()
                
            }.toast(isShowing: $showToast, text: Text(isAdd ? "Added to favourite" : "Remove from favourite"))
            .padding(.horizontal)
        } else {
            ProgressView("loading").progressViewStyle(.circular)
        }
       
    }
    
    func getArtistsName(event: Event?) -> String{
        event?.embedded?.attractions?.compactMap({ attract in
            return attract.name
        }).joined(separator: "/") ?? ""
    }
    
    func getGenre(_ event: Event?) -> String {
        guard let cls = event?.classifications?.first else {
            return ""
        }
        return "\(cls.genre?.name ?? "") | \(cls.subGenre?.name ?? "") | \(cls.segment?.name ?? "")"
    }
    
    func getColor(status: String) -> Color{
        switch (status.lowercased()) {
        case "onsale":
            return Color.green
        case "offsale":
            return Color.red
        case "canceled":
            return Color.black
        case "postponed":
            return Color.orange
        case "rescheduled":
            return Color.orange
        default:
            return Color.green
        }
    }
    
    func generateView2() -> some View {
        return Group{
            HStack {
                Text("Price Range")
                    .font(.title3)
                Spacer()
                Text("Ticket Status")
                    .font(.title3)
            }
            HStack {
                Text("\(Int(event?.priceRanges?.first?.min ?? 0))-\(Int(event?.priceRanges?.first?.max ?? 0))")
                    .foregroundColor(Color.gray)
                Spacer()
                Button("\(event?.dates?.status?.code ?? "")", action: {}).frame(width: 120.0, height: 30.0).background(getColor(status: event?.dates?.status?.code ?? "")).foregroundColor(Color.white).cornerRadius(8)
            }
            if let event = event {
                if (eventStore.isCollect(event: event)) {
                    Button("Remove Favourite", action: {
                        isAdd = false
                        showToast = true
                        eventStore.delete(event: event)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                          withAnimation {
                            showToast = false
                          }
                        }
                    }).frame(width: 150, height: 40).background(Color.red).foregroundColor(Color.white).cornerRadius(8)
                } else {
                    Button("Save Event", action: {
                        isAdd = true
                        showToast = true
                        eventStore.save(event: event)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                          withAnimation {
                            showToast = false
                          }
                        }
                    }).frame(width: 150, height: 40).background(Color.blue).foregroundColor(Color.white).cornerRadius(8)
                }
            }
            if (event?.seatmap?.staticURL != nil) {
                HStack {
                    KFImage(URL(string: event?.seatmap?.staticURL ?? "")!).resizable().scaledToFill().frame(width: 200, height:200)
                }
            }
        }
    }
    
    func generateView1() -> some View {
        return Group {
            Text(event?.name ?? "")
                .font(.title)
                .fontWeight(.bold)
            HStack {
                Text("Date")
                    .font(.title3)
                Spacer()
                Text("Artisit/Team")
                    .font(.title3)
            }
            HStack {
                Text(event?.dates?.start?.localDate ?? "")
                    .foregroundColor(Color.gray)
                Spacer()
                Text(getArtistsName(event: event))
                    .foregroundColor(Color.gray)
            }
            .padding(.bottom)
            HStack {
                Text("Venue")
                    .font(.title3)
                Spacer()
                Text("Genre")
                    .font(.title3)
            }
            HStack {
                Text(event?.embedded?.venues?.first?.name ?? "")
                    .foregroundColor(Color.gray)
                Spacer()
                Text(getGenre(event))
                    .foregroundColor(Color.gray)
            }
            .padding(.bottom)
        }
    }
}

class DetailStore : ObservableObject {
    @Published var detail:Event?
    var id: String
    
    
    init(id: String) {
        self.id = id
        load()
    }
    
    func load() {
        APIHandler.sharedInstance.getDetail(id: id) { res in
            self.detail = res
        }
    }
    
}
