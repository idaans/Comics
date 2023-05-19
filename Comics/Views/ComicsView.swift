//
//  ComicsView.swift
//  Comics
//
//  Created by Ida Anseth  on 01/05/2023.
//

import Foundation
import UIKit

class ComicsView: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var comicsImage: UIImageView!
    @IBOutlet weak var comicTitle: UILabel!
    
    var comicsManager = ComicsManager()
    var comics: ComicsModel?
    var comicNumber = 1
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        comicsManager.delegate = self
        fetchComics()
    }
    
    func fetchComics(){
        let number = String(comicNumber)
        comicsManager.fetchComics(number: number)
    }
}

extension ComicsView : ComicsManagerDelegate {
    func updateComics(_ comicsManager: ComicsManager, comic: ComicsModel) {
        comics = comic
        DispatchQueue.main.async {
            self.comicTitle.text = "\(comic.title) (\(self.comicNumber)"
            print("Henter comicnr")
        }
        ImageHelper().fetchImage(comic.img){ image in
            DispatchQueue.main.async {
                self.comicsImage.image = image ?? UIImage(named: "Image not found")
                print("Fetching image")
            }
        }
    }
    func failWithError(error: Error) {
        print("Feiler på fetch comic")
        print(error.localizedDescription)
    }
}
