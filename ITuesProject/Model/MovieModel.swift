//
//  MovieModel.swift
//  ITuesProject
//
//  Created by Amol Pawar on 01/08/22.
//

import Foundation

// MARK: - MovieModel
struct MovieModel: Decodable {
    let resultCount: Int
    let movies: [Movie]

    enum CodingKeys: String, CodingKey {
        case resultCount
        case movies = "results"
    }
}


// MARK: - Result
struct Movie: Decodable, Identifiable {
    let wrapperType, kind: String?
    let collectionID: Int?
    let id: Int
    let artistName, collectionName, trackName: String?
    let trackCensoredName: String?
    let collectionArtistID: Int?
    let collectionArtistViewURL, collectionViewURL, trackViewURL: String?
    let previewURL: String?
    let artworkUrl30, artworkUrl60, artworkUrl100: String?
    let collectionPrice, trackPrice, trackRentalPrice, collectionHDPrice: Double?
    let trackHDPrice, trackHDRentalPrice: Double?
    let releaseDate: String?
    let collectionExplicitness, trackExplicitness: String?
    let trackCount, trackNumber, trackTimeMillis: Int?
    let country, currency, primaryGenreName, contentAdvisoryRating: String?
    let longDescription: String?
    let hasITunesExtras: Bool?

    enum CodingKeys: String, CodingKey {
        case wrapperType, kind
        case collectionID = "collectionId"
        case id = "trackId"
        case artistName, collectionName, trackName, trackCensoredName
        case collectionArtistID = "collectionArtistId"
        case collectionArtistViewURL = "collectionArtistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, trackRentalPrice
        case collectionHDPrice = "collectionHdPrice"
        case trackHDPrice = "trackHdPrice"
        case trackHDRentalPrice = "trackHdRentalPrice"
        case releaseDate, collectionExplicitness, trackExplicitness, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, contentAdvisoryRating, longDescription, hasITunesExtras
    }

    static func loadData() -> [Movie] {
        return [
            Movie(wrapperType:"track", kind:"feature-movie", collectionID:1636409066, id:455832983, artistName:"David Yates", collectionName:"Harry Potter and the Deathly Hallows, Part 2", trackName:"Harry Potter 8-Film + Return to Hogwarts", trackCensoredName:"Harry Potter and the Deathly Hallows, Part 2", collectionArtistID:199257486, collectionArtistViewURL:"https://itunes.apple.com/us/artist/warner-bros-entertainment-inc/199257486?uo=4", collectionViewURL:"https://itunes.apple.com/us/movie/harry-potter-and-the-deathly-hallows-part-2/id455832983?uo=4", trackViewURL:"https://itunes.apple.com/us/movie/harry-potter-and-the-deathly-hallows-part-2/id455832983?uo=4",
                 previewURL:"https://video-ssl.itunes.apple.com/itunes-assets/Video127/v4/21/a9/b3/21a9b303-1e96-0ccd-1e7a-10f7ac860648/mzvf_8404905858121608385.640x362.h264lc.U.p.m4v", artworkUrl30:"https://is2-ssl.mzstatic.com/image/thumb/Video124/v4/08/47/89/084789b6-920e-afa3-e89b-2032e4659f43/pr_source.lsr/30x30bb.jpg", artworkUrl60:"https://is2-ssl.mzstatic.com/image/thumb/Video124/v4/08/47/89/084789b6-920e-afa3-e89b-2032e4659f43/pr_source.lsr/60x60bb.jpg", artworkUrl100:"https://is2-ssl.mzstatic.com/image/thumb/Video124/v4/08/47/89/084789b6-920e-afa3-e89b-2032e4659f43/pr_source.lsr/100x100bb.jpg", collectionPrice:9.99, trackPrice:9.99, trackRentalPrice:3.99, collectionHDPrice:9.99, trackHDPrice:9.99, trackHDRentalPrice:3.99, releaseDate:"2011-07-14T07:00:00Z", collectionExplicitness:"notExplicit", trackExplicitness:"notExplicit", trackCount:9, trackNumber:8, trackTimeMillis:7836618, country:"USA", currency:"USD", primaryGenreName:"Kids & Family", contentAdvisoryRating:"PG-13",
                 longDescription:"\"Harry Potter and the Deathly Hallows - Part 2,\" is the final adventure in the Harry Potter film series. The much-anticipated motion picture event is the second of two full-length parts. In the epic finale, the battle between the good and evil forces of the wizarding world escalates into an all-out war. The stakes have never been higher and no one is safe. But it is Harry Potter who may be called upon to make the ultimate sacrifice as he draws closer to the climactic showdown with Lord Voldemort. It all ends here.", hasITunesExtras:true)
        ]
    }
}
