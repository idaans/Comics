//
//  ComicsModel.swift
//  Comics
//
//  Created by Ida Anseth  on 01/05/2023.
//

import Foundation

struct ComicsModel: Codable {
    let month: String
    let day: String
    let year: String
    let number: Int
    let news: String
    let link: String
    let transcript: String
    let image: String
    let title: String
    let safeTitle: String
    let alternativeText: String
}

//typealias Comics = [ComicsModel]
