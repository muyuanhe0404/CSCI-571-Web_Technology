//
//  Cache.swift
//  mobile_search
//
//  Created by HMY on 2023/4/22.
//

import Foundation

class EventStore : ObservableObject {
    @Published var events = [Event]()
    
    
    init() {
        load()
    }
    
    func load() {
        events = CacheManager.sharedInstance.getAllFavourites()
    }
    
    func save(event: Event) {
        events.append(event)
        CacheManager.sharedInstance.saveEvent(event: event)
    }
    
    func delete(event: IndexSet) {
        events.remove(atOffsets: event)
        CacheManager.sharedInstance.saveAll(event: events)
    }
    
    func delete(event: Event) {
        CacheManager.sharedInstance.deleteEvent(event: event)
        events.removeAll { e in
            return e.id == event.id
        }
    }
    
    func isCollect(event: Event) -> Bool {
        return CacheManager.sharedInstance.isCollect(event: event)
    }
}

class CacheManager {
    static let sharedInstance = CacheManager()
    let key = "favourites"
    
    func getAllFavourites() -> [Event]{
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            let decoder = JSONDecoder()
            let res = try decoder.decode([Event].self, from: data)
            return res
        } catch {
            return []
        }
    }
    
    func saveEvent(event: Event) {
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Write/Set Data
            var all = getAllFavourites()
            all.append(event)
            let data = try encoder.encode(all)
            UserDefaults.standard.set(data, forKey: key)

        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
    
    func saveAll(event: [Event]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(event)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            
        }
    }
    
    func deleteEvent(event: Event) {
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Write/Set Data
            var all = getAllFavourites()
            
            all = all.filter { e in
                return event.id != e.id
            }
            let data = try encoder.encode(all)
            UserDefaults.standard.set(data, forKey: key)

        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
    
    func isCollect(event: Event) -> Bool {
        var all = getAllFavourites()
        return all.contains(where: { e in
            return e.id == event.id
        })
    }
}
