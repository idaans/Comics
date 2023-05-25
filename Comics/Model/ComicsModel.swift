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
    
    init(month: String, day: String, year: String, num: Int, news: String, link: String, transcript: String, img: String, title: String, safe_title: String, alt: String) {
        self.month = month
        self.day = day
        self.year = year
        self.num = num
        self.news = news
        self.link = link
        self.transcript = transcript
        self.img = img
        self.title = title
        self.safe_title = safe_title
        self.alt = alt
    }
}
