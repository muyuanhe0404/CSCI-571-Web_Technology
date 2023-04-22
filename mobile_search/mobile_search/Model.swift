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

