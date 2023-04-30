//
//  ArtistView.swift
//  mobile_search
//
//  Created by HMY on 2023/4/21.
//

import SwiftUI
import Combine
import Kingfisher

class ViewModel: ObservableObject {
    
    // model
    @Published var items: [ArtistElement]?
    @Published var tracks: [String: SearchTrackResp] = [:]
    
    var subscriptions = Set<AnyCancellable>()
    
    func getData(event: Event?) {
        APIHandler.sharedInstance.searchArtist(artist: event?.embedded?.attractions?.first?.name ?? "") { resp in
            DispatchQueue.main.async {
                self.items = resp?.body?.artists?.items
            }
            resp?.body?.artists?.items?.forEach({ artist in
                APIHandler.sharedInstance.getAlbum(id: artist.id ?? "") { resp in
                    DispatchQueue.main.async {
                        if let resp = resp {
                            self.tracks[artist.id ?? ""] = resp
                        }
                    }
                }
            })
            
        }
        
    }
    
}

struct ArtistView: View {
    var event: Event?
    @ObservedObject var viewModel = ViewModel()
    var body: some View {
        if (event?.classifications?[0].segment?.name == "Music") {
            if (viewModel.items?.count ?? 0) > 0 {
                List {
                    ForEach(viewModel.items ?? []) { artist in
                        ZStack {
                            Color.brown
                            VStack {
                                getView(artist)
                                Text("Popular Albums")
                                HStack {
                                    if let first = viewModel.tracks[artist.id ?? ""]?.items?.first {
                                        KFImage(URL(string: first.images?.first?.url ?? "")!).resizable().frame(width: 40, height: 40)
                                    }
                                    if (viewModel.tracks[artist.id ?? ""]?.items?.count ?? 0) > 1 {
                                        KFImage(URL(string: viewModel.tracks[artist.id ?? ""]?.items?[1].images?.first?.url ?? "")!).resizable().frame(width: 40, height: 40)
                                    }
                                    if (viewModel.tracks[artist.id ?? ""]?.items?.count ?? 0) > 2 {
                                        KFImage(URL(string: viewModel.tracks[artist.id ?? ""]?.items?[2].images?.first?.url ?? "")!).resizable().frame(width: 40, height: 40)
                                    }
                                }
                            }
                        }.cornerRadius(8).onTapGesture {
                            UIApplication.shared.openURL(URL(string: artist.externalUrls?.spotify ?? "")!)
                        }
                    }
                }
                
            } else {
                Text("No music related artists detail to show")
            }
        } else {
            Text("No music related artists detail to show")
        }
    }
    
    init(event: Event? = nil) {
        self.event = event
        viewModel.getData(event: event)
    }
    
    func getTotalFollowers(artist: ArtistElement) -> String {
        guard let total = artist.followers?.total else {
            return "No Follower"
        }
        return total > 1000000 ? "\(total/1000000)M Followers" : (total > 1000 ? "\(total/1000)K Followers" : "\(total) Followers")
    }
    
    func getView(_ artist: ArtistElement) -> some View{
        return HStack {
            if let url = artist.images?.first?.url {
                KFImage(URL(string: url)!).resizable()
                    .scaledToFill().frame(width: 60, height:60).cornerRadius(8)
            }
            
            VStack {
                Text(artist.name ?? "")
                Text(getTotalFollowers(artist: artist))
                HStack {
                    Image("spotify").resizable().frame(width: 20, height: 20)
                    Text("spotify").foregroundColor(Color.green)
                }
            }
            VStack {
                Text("Popularity")
                ZStack {
                    CircularProgressView(progress: (Double(artist.popularity ?? 0) / 100.0))
                    Text("\(artist.popularity ?? 0)")
                        .foregroundColor(Color.white)
                }.frame(width: 50, height: 50)
                
            }
        }
    }
}

struct ArtistView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistView()
    }
}

struct CircularProgressView: View {
    // 1
    let progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.yellow.opacity(0.5),
                    lineWidth: 10
                )
            Circle()
            // 2
                .trim(from: 0, to: progress)
                .stroke(
                    Color.yellow,
                    style: StrokeStyle(
                        lineWidth: 10,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
        }
    }
}
