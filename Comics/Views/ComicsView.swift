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
    @IBOutlet weak var numberLabel: UILabel!
    
    var comicsManager = ComicsManager()
    var comics: ComicsModel?
    var comicNumber = Int.random(in: 1..<2777)
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        comicsManager.delegate = self
        fetchComics()
    }
    
    //TODO: Fetch on id, number is being printed in title
    func fetchComics(){
        let number = String(comicNumber)
        comicsManager.fetchComics(number: number)
    }
    
    //TODO: Get random comic on button
    
    @IBAction func randomButton(_ sender: Any) {
        randomComic()
        fetchComics()
    }
    
    //Fetching random comic onPress button
    func randomComic(){
        let randomNumber = Int.random(in: 1..<2777)
        comicNumber = randomNumber
    }
    
    @IBAction func infoPressed(_ sender: Any) {
        infoAlert()
        print("Info pressed")
    }
    
    //Fix optional
    //Can not force unwrap in case of crash
    //Removing optional string with operator ?? ""
    func infoAlert(){
        let comicInfo = "\n Comic #\(comics?.num ?? 00) Released: \(comics?.month ?? "").\(comics?.day ?? "").\(comics?.year ?? "")"
        let titleText = "\(comics?.alt ?? "")"
        let alert = UIAlertController(title: titleText, message: comicInfo, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension ComicsView : ComicsManagerDelegate {
    func updateComics(_ comicsManager: ComicsManager, comic: ComicsModel) {
        comics = comic
        DispatchQueue.main.async {
            self.comicTitle.text = "\(comic.title)"
            self.numberLabel.text = "#\(comic.num)"
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
