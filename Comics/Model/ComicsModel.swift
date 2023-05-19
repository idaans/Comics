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
    let num: Int
    let news: String
    let link: String
    let transcript: String
    let img: String
    let title: String
    let safe_title: String
    let alt: String
}

//typealias Comics = [ComicsModel]
