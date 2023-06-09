//
//  ComicsManager.swift
//  Comics
//
//  Created by Ida Anseth  on 01/05/2023.
//

import Foundation

// Delegate for updating comics and pasing error if there are any
protocol ComicsManagerDelegate {
    func updateComics(_ comicsManager: ComicsManager, comic: ComicsModel)
    func failWithError(error: Error)
}

struct ComicsManager {
    
    // Optional delegate for possibility to be nil
    var delegate: ComicsManagerDelegate?
    
    // Fetch on comic number with url
    func fetchComics(number: String){
        let urlComicString = "https://xkcd.com/\(number)/info.0.json"
        fetchRequest(with: urlComicString)
    }
    
    // Fetch comics on request
    func fetchRequest(with urlComicString: String){
        let url = URL(string: urlComicString)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                print("Could not fetch")
                return
            }
            if let safeData = data {
                if let comic = self.parseJSON(safeData){
                    self.delegate?.updateComics(self, comic: comic)
                }
            }
        }
        print("Fetch succeess")
        dataTask.resume()
    }
    
    // Parse JSON with decoder to match variables in ComicsModel
    func parseJSON(_ comicsData: Data) -> ComicsModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ComicsModel.self, from: comicsData)
            let month = decodedData.month
            let day = decodedData.day
            let year = decodedData.year
            let num = decodedData.num
            let news = decodedData.news
            let link = decodedData.link
            let transcript = decodedData.transcript
            let img = decodedData.img
            let title = decodedData.title
            let safe_title = decodedData.safe_title
            let alt = decodedData.alt
            
            let comic = ComicsModel(month: month, day: day, year: year, num: num, news: news, link: link, transcript: transcript, img: img, title: title, safe_title: safe_title, alt: alt)
            return comic
        } catch {
            delegate?.failWithError(error: error)
            return nil
        }
    }
}
