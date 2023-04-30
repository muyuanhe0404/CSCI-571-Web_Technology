//
//  Model.swift
//  mobile_search
//
//  Created by HMY on 2023/4/19.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

struct SearchResposne: Codable {
    let embedded: Embedded?
    let links: Links?
    let page: Page?

    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
        case links = "_links"
        case page
    }
}

struct Embedded: Codable {
    let events: [Event]?
}

// MARK: - Event
struct Event: Codable, Identifiable {
    let name, type, id: String?
    let test: Bool?
    let url: String?
    let locale: String?
    let images: [MImage]?
    let sales: Sales?
    let dates: Dates?
    let classifications: [Classification]?
    let promoter: Promoter?
    let promoters: [Promoter]?
    let pleaseNote: String?
    let priceRanges: [PriceRange]?
    let seatmap: Seatmap?
    let accessibility: Accessibility?
    let ticketLimit: TicketLimit?
    let ageRestrictions: AgeRestrictions?
    let ticketing: Ticketing?
    let links: EventLinks?
    let embedded: EventEmbedded?

    enum CodingKeys: String, CodingKey {
        case name, type, id, test, url, locale, images, sales, dates, classifications, promoter, promoters, pleaseNote, priceRanges, seatmap, accessibility, ticketLimit, ageRestrictions, ticketing
        case links = "_links"
        case embedded = "_embedded"
    }
}

// MARK: - Accessibility
struct Accessibility: Codable {
    let ticketLimit: Int?
}

// MARK: - AgeRestrictions
struct AgeRestrictions: Codable {
    let legalAgeEnforced: Bool?
}

// MARK: - Classification
struct Classification: Codable {
    let primary: Bool?
    let segment, genre, subGenre, type: Genre?
    let subType: Genre?
    let family: Bool?
}

// MARK: - Genre
struct Genre: Codable {
    let id, name: String?
}

// MARK: - Dates
struct Dates: Codable {
    let start: Start?
    let timezone: String?
    let status: Status?
    let spanMultipleDays: Bool?
}

// MARK: - Start
struct Start: Codable {
    let localDate, localTime: String?
    let dateTime: String?
    let dateTBD, dateTBA, timeTBA, noSpecificTime: Bool?
}

// MARK: - Status
struct Status: Codable {
    let code: String?
}

// MARK: - EventEmbedded
struct EventEmbedded: Codable {
    let venues: [Venue]?
    let attractions: [Attraction]?
}

// MARK: - Attraction
struct Attraction: Codable {
    let name, type, id: String?
    let test: Bool?
    let url: String?
    let locale: String?
    let externalLinks: ExternalLinks?
    let images: [MImage]?
    let classifications: [Classification]?
    let upcomingEvents: AttractionUpcomingEvents?
    let links: AttractionLinks?

    enum CodingKeys: String, CodingKey {
        case name, type, id, test, url, locale, externalLinks, images, classifications, upcomingEvents
        case links = "_links"
    }
}

// MARK: - ExternalLinks
struct ExternalLinks: Codable {
    let youtube, twitter, itunes, lastfm: [Facebook]?
    let facebook, wiki, spotify, instagram: [Facebook]?
    let musicbrainz: [Musicbrainz]?
    let homepage: [Facebook]?
}

// MARK: - Facebook
struct Facebook: Codable {
    let url: String?
}

// MARK: - Musicbrainz
struct Musicbrainz: Codable {
    let id: String?
}

// MARK: - Image
struct MImage: Codable {
    let ratio: Ratio?
    let url: String?
    let width, height: Int?
    let fallback: Bool?
}

enum Ratio: String, Codable {
    case the16_9 = "16_9"
    case the3_2 = "3_2"
    case the4_3 = "4_3"
}

// MARK: - AttractionLinks
struct AttractionLinks: Codable {
    let linksSelf: First?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

// MARK: - First
struct First: Codable {
    let href: String?
}

// MARK: - AttractionUpcomingEvents
struct AttractionUpcomingEvents: Codable {
    let total, tmr, ticketmaster, filtered: Int?
    let mfxNl, ticketweb: Int?

    enum CodingKeys: String, CodingKey {
        case total = "_total"
        case tmr, ticketmaster
        case filtered = "_filtered"
        case mfxNl = "mfx-nl"
        case ticketweb
    }
}

// MARK: - Venue
struct Venue: Codable {
    let name, type, id: String?
    let test: Bool?
    let url: String?
    let locale: String?
    let aliases: [String]?
    let images: [MImage]?
    let postalCode, timezone: String?
    let city: City?
    let state: MState?
    let country: Country?
    let address: Address?
    let location: Location?
    let markets: [Genre]?
    let dmas: [DMA]?
    let social: Social?
    let boxOfficeInfo: BoxOfficeInfo?
    let parkingDetail, accessibleSeatingDetail: String?
    let generalInfo: GeneralInfo?
    let upcomingEvents: VenueUpcomingEvents?
    let ada: Ada?
    let links: AttractionLinks?

    enum CodingKeys: String, CodingKey {
        case name, type, id, test, url, locale, aliases, images, postalCode, timezone, city, state, country, address, location, markets, dmas, social, boxOfficeInfo, parkingDetail, accessibleSeatingDetail, generalInfo, upcomingEvents, ada
        case links = "_links"
    }
}

// MARK: - Ada
struct Ada: Codable {
    let adaPhones, adaCustomCopy, adaHours: String?
}

// MARK: - Address
struct Address: Codable {
    let line1: String?
}

// MARK: - BoxOfficeInfo
struct BoxOfficeInfo: Codable {
    let phoneNumberDetail, openHoursDetail, acceptedPaymentDetail, willCallDetail: String?
}

// MARK: - City
struct City: Codable {
    let name: String?
}

// MARK: - Country
struct Country: Codable {
    let name, countryCode: String?
}

// MARK: - DMA
struct DMA: Codable {
    let id: Int?
}

// MARK: - GeneralInfo
struct GeneralInfo: Codable {
    let generalRule, childRule: String?
}

// MARK: - Location
struct Location: Codable {
    let longitude, latitude: String?
}

// MARK: - Social
struct Social: Codable {
    let twitter: Twitter?
}

// MARK: - Twitter
struct Twitter: Codable {
    let handle: String?
}

// MARK: - State
struct MState: Codable {
    let name, stateCode: String?
}

// MARK: - VenueUpcomingEvents
struct VenueUpcomingEvents: Codable {
    let total, tmr, ticketmaster, filtered: Int?

    enum CodingKeys: String, CodingKey {
        case total = "_total"
        case tmr, ticketmaster
        case filtered = "_filtered"
    }
}

// MARK: - EventLinks
struct EventLinks: Codable {
    let linksSelf: First?
    let attractions, venues: [First]?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case attractions, venues
    }
}

// MARK: - PriceRange
struct PriceRange: Codable {
    let type, currency: String?
    let min, max: Double?
}

// MARK: - Promoter
struct Promoter: Codable {
    let id, name, description: String?
}

// MARK: - Sales
struct Sales: Codable {
    let salesPublic: Public?
    let presales: [Presale]?

    enum CodingKeys: String, CodingKey {
        case salesPublic = "public"
        case presales
    }
}

// MARK: - Presale
struct Presale: Codable {
    let startDateTime, endDateTime: String?
    let name: String?
}

// MARK: - Public
struct Public: Codable {
    let startDateTime: String?
    let startTBD, startTBA: Bool?
    let endDateTime: String?
}

// MARK: - Seatmap
struct Seatmap: Codable {
    let staticURL: String?

    enum CodingKeys: String, CodingKey {
        case staticURL = "staticUrl"
    }
}

// MARK: - TicketLimit
struct TicketLimit: Codable {
    let info: String?
}

// MARK: - Ticketing
struct Ticketing: Codable {
    let safeTix: SafeTix?
}

// MARK: - SafeTix
struct SafeTix: Codable {
    let enabled: Bool?
}

// MARK: - WelcomeLinks
struct Links: Codable {
    let first, linksSelf, next, last: First?

    enum CodingKeys: String, CodingKey {
        case first
        case linksSelf = "self"
        case next, last
    }
}

// MARK: - Page
struct Page: Codable {
    let size, totalElements, totalPages, number: Int?
}

struct SearchArtist: Codable {
    let tracks: Tracks?
    let artists: Artists?
    let albums: Albums?
    let playlists: Playlists?
    let shows: Audiobooks?
    let episodes: Episodes?
    let audiobooks: Audiobooks?
}

// MARK: - Albums
struct Albums: Codable {
    let href: String?
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let total: Int?
    let items: [AlbumElement]?
}

// MARK: - AlbumElement
struct AlbumElement: Codable {
    let albumType: String?
    let totalTracks: Int?
    let availableMarkets: [String]?
    let externalUrls: ExternalUrls?
    let href: String?
    let id: String?
    let images: [SpotifyImage]?
    let name: String?
    let releaseDate, releaseDatePrecision: String?
    let restrictions: Restrictions?
    let type, uri: String?
    let copyrights: [Copyright]?
    let externalIDS: ExternalIDS?
    let genres: [String]?
    let label: String?
    let popularity: Int?
    let albumGroup: String?
    let artists: [Artist]?

    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case totalTracks = "total_tracks"
        case availableMarkets = "available_markets"
        case externalUrls = "external_urls"
        case href, id, images, name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case restrictions, type, uri, copyrights
        case externalIDS = "external_ids"
        case genres, label, popularity
        case albumGroup = "album_group"
        case artists
    }
}

// MARK: - Artist
struct Artist: Codable {
    let externalUrls: ExternalUrls?
    let href, id, name: String?
    let type: String?
    let uri: String?

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case href, id, name, type, uri
    }
}

// MARK: - ExternalUrls
struct ExternalUrls: Codable {
    let spotify: String?
}

// MARK: - Copyright
struct Copyright: Codable {
    let text, type: String?
}

// MARK: - ExternalIDS
struct ExternalIDS: Codable {
    let isrc, ean, upc: String?
}

// MARK: - Image
struct SpotifyImage: Codable {
    let url: String?
    let height, width: Int?
}

// MARK: - Restrictions
struct Restrictions: Codable {
    let reason: String?
}

struct SearchArtistResp: Codable {
    let body: Body?
    let statusCode: Int?
}

// MARK: - Body
struct Body: Codable {
    let artists: Artists?
}
// MARK: - Artists
struct Artists: Codable {
    let href: String?
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let total: Int?
    let items: [ArtistElement]?
}

// MARK: - ArtistElement
struct ArtistElement: Codable,Identifiable {
    let externalUrls: ExternalUrls?
    let followers: Followers?
    let genres: [String]?
    let href, id: String?
    let images: [SpotifyImage]?
    let name: String?
    let popularity: Int?
    let type: String?
    let uri: String?

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case followers, genres, href, id, images, name, popularity, type, uri
    }
}

// MARK: - Followers
struct Followers: Codable {
    let href: String?
    let total: Int?
}

// MARK: - Audiobooks
struct Audiobooks: Codable {
    let href: String?
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let total: Int?
    let items: [AudiobooksItem]?
}

// MARK: - AudiobooksItem
struct AudiobooksItem: Codable {
    let authors: [Author]?
    let availableMarkets: [String]?
    let copyrights: [Copyright]?
    let description, htmlDescription: String?
    let edition: String?
    let explicit: Bool?
    let externalUrls: ExternalUrls?
    let href, id: String?
    let images: [SpotifyImage]?
    let languages: [String]?
    let mediaType, name: String?
    let narrators: [Author]?
    let publisher: String?
    let type: String?
    let uri: String?
    let totalChapters: Int?
    let isExternallyHosted: Bool?
    let totalEpisodes: Int?

    enum CodingKeys: String, CodingKey {
        case authors
        case availableMarkets = "available_markets"
        case copyrights, description
        case htmlDescription = "html_description"
        case edition, explicit
        case externalUrls = "external_urls"
        case href, id, images, languages
        case mediaType = "media_type"
        case name, narrators, publisher, type, uri
        case totalChapters = "total_chapters"
        case isExternallyHosted = "is_externally_hosted"
        case totalEpisodes = "total_episodes"
    }
}

// MARK: - Author
struct Author: Codable {
    let name: String?
}

// MARK: - Episodes
struct Episodes: Codable {
    let href: String?
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let total: Int?
    let items: [EpisodesItem]?
}

// MARK: - EpisodesItem
struct EpisodesItem: Codable {
    let audioPreviewURL: String?
    let description, htmlDescription: String?
    let durationMS: Int?
    let explicit: Bool?
    let externalUrls: ExternalUrls?
    let href: String?
    let id: String?
    let images: [SpotifyImage]?
    let isExternallyHosted, isPlayable: Bool?
    let language: String?
    let languages: [String]?
    let name, releaseDate, releaseDatePrecision: String?
    let resumePoint: ResumePoint?
    let type, uri: String?
    let restrictions: Restrictions?

    enum CodingKeys: String, CodingKey {
        case audioPreviewURL = "audio_preview_url"
        case description
        case htmlDescription = "html_description"
        case durationMS = "duration_ms"
        case explicit
        case externalUrls = "external_urls"
        case href, id, images
        case isExternallyHosted = "is_externally_hosted"
        case isPlayable = "is_playable"
        case language, languages, name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case resumePoint = "resume_point"
        case type, uri, restrictions
    }
}

// MARK: - ResumePoint
struct ResumePoint: Codable {
    let fullyPlayed: Bool?
    let resumePositionMS: Int?

    enum CodingKeys: String, CodingKey {
        case fullyPlayed = "fully_played"
        case resumePositionMS = "resume_position_ms"
    }
}

// MARK: - Playlists
struct Playlists: Codable {
    let href: String?
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let total: Int?
    let items: [PlaylistsItem]?
}

// MARK: - PlaylistsItem
struct PlaylistsItem: Codable {
    let collaborative: Bool?
    let description: String?
    let externalUrls: ExternalUrls?
    let href, id: String?
    let images: [SpotifyImage]?
    let name: String?
    let owner: Owner?
    let itemPublic: Bool?
    let snapshotID: String?
    let tracks: Followers?
    let type, uri: String?

    enum CodingKeys: String, CodingKey {
        case collaborative, description
        case externalUrls = "external_urls"
        case href, id, images, name, owner
        case itemPublic = "public"
        case snapshotID = "snapshot_id"
        case tracks, type, uri
    }
}

// MARK: - Owner
struct Owner: Codable {
    let externalUrls: ExternalUrls?
    let followers: Followers?
    let href, id: String?
    let type: String?
    let uri, displayName: String?

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case followers, href, id, type, uri
        case displayName = "display_name"
    }
}

// MARK: - Tracks
struct Tracks: Codable {
    let href: String?
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let total: Int?
    let items: [TracksItem]?
}

// MARK: - TracksItem
struct TracksItem: Codable {
    let album: AlbumElement?
    let artists: [ArtistElement]?
    let availableMarkets: [String]?
    let discNumber, durationMS: Int?
    let explicit: Bool?
    let externalIDS: ExternalIDS?
    let externalUrls: ExternalUrls?
    let href, id: String?
    let isPlayable: Bool?
    let linkedFrom: LinkedFrom?
    let restrictions: Restrictions?
    let name: String?
    let popularity: Int?
    let previewURL: String?
    let trackNumber: Int?
    let type: String?
    let uri: String?
    let isLocal: Bool?

    enum CodingKeys: String, CodingKey {
        case album, artists
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case explicit
        case externalIDS = "external_ids"
        case externalUrls = "external_urls"
        case href, id
        case isPlayable = "is_playable"
        case linkedFrom = "linked_from"
        case restrictions, name, popularity
        case previewURL = "preview_url"
        case trackNumber = "track_number"
        case type, uri
        case isLocal = "is_local"
    }
}

// MARK: - LinkedFrom
struct LinkedFrom: Codable {
}

// MARK: - Welcome
struct GetGeoResp: Codable {
    let results: [Result]?
    let status: String?
}

// MARK: - Result
struct Result: Codable {
    let addressComponents: [AddressComponent]?
    let geometry: Geometry?
    let placeID: String?
    let types: [String]?

    enum CodingKeys: String, CodingKey {
        case addressComponents = "address_components"
        case geometry
        case placeID = "place_id"
        case types
    }
}

// MARK: - AddressComponent
struct AddressComponent: Codable {
    let shortName: String?
    let types: [String]?

    enum CodingKeys: String, CodingKey {
        case shortName = "short_name"
        case types
    }
}

// MARK: - Geometry
struct Geometry: Codable {
    let bounds: Bounds?
    let location: GLocation?
    let locationType: String?
    let viewport: Bounds?

    enum CodingKeys: String, CodingKey {
        case bounds, location
        case locationType = "location_type"
        case viewport
    }
}

// MARK: - Bounds
struct Bounds: Codable {
    let northeast, southwest: Location?
}

// MARK: - Location
struct GLocation: Codable {
    let lat, lng: Double?
}

struct SearchTrackResp: Codable {
    let href: String?
    let items: [Item]?
    let limit: Int?
    let next: String?
    let offset: Int?
    let total: Int?
}

// MARK: - Item
struct Item: Codable {
    let albumGroup, albumType: String?
    let artists: [Artist]?
    let availableMarkets: [String]?
    let externalUrls: ExternalUrls?
    let href: String?
    let id: String?
    let images: [SpotifyImage]?
    let name, releaseDate, releaseDatePrecision: String?
    let totalTracks: Int?
    let type, uri: String?

    enum CodingKeys: String, CodingKey {
        case albumGroup = "album_group"
        case albumType = "album_type"
        case artists
        case availableMarkets = "available_markets"
        case externalUrls = "external_urls"
        case href, id, images, name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case totalTracks = "total_tracks"
        case type, uri
    }
}

struct IPInfo : Codable {
    let loc: String?
    enum CodingKeys: String, CodingKey {
        case loc
    }
}


