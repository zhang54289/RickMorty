//
//  CharacterResponseModel.swift
//  RickMorty
//
//  Created by Huan Zhang on 4/9/25.
//

import Foundation

struct CharacterResponseModel: Codable {
    let info: Info
    let results: [Character]
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Character: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: LocationInfo
    let location: LocationInfo
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct LocationInfo: Codable, Equatable {
    let name: String
    let url: String
}
