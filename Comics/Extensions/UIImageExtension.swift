//
//  ImageHelper.swift
//  Comics
//
//  Created by Ida Anseth  on 02/05/2023.
//

import Foundation
import UIKit

class ImageHelper {
    
    // Async fetching image from the url API if it exist.
    func fetchImage(_ image: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: image) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(nil)
                return
            }
            guard let httpURLResponse = response  as? HTTPURLResponse,
                  httpURLResponse.statusCode == 200,
                  let data = data else{
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }
        .resume()
    }
}
