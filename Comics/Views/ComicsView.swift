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
    @IBOutlet weak var inputTextField: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var comicsManager = ComicsManager()
    var addFavoriteComics = FavoriteComicsView()
    var favoriteComicsManager = FavoriteComicsManager()
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

    
    @IBAction func randomButton(_ sender: Any){
        fetchComics()
        randomComic()
    }
    
    //Fetching random comic onPress button
    func randomComic(){
        let randomNumber = Int.random(in: 1..<2777)
        comicNumber = randomNumber
    }
    
    @IBAction func infoPressed(_ sender: Any){
        infoAlert()
        print("Info pressed")
    }
    
    //Removing optional string with operator ?? ""
    func infoAlert(){
        let comicInfo = "\n Comic #\(comics?.num ?? 00) Released: \(comics?.month ?? "").\(comics?.day ?? "").\(comics?.year ?? "")"
        let titleText = "\(comics?.alt ?? "")"
        let alert = UIAlertController(title: titleText, message: comicInfo, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    //Check text input field, remove keyboard when editing end
    @IBAction func searchIconPressed(_ sender: Any) {
        textInput()
        inputTextField.endEditing(true)
        inputTextField.text = ""
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textInput()
        return true
    }
    
    func textInput(){
        //Check input number, if match show comic, if not show error
        //Search by int with operatores
        let newComic = Int(inputTextField.text ?? "") ?? 0
        if newComic < 1 || newComic > 1 {
            comicsManager.fetchComics(number: String(newComic))
            print("Henter comic: \(newComic)")
        } else {
            print("Cant fetch comic")
        }
    }
    
    
    @IBAction func favoritePressed(_ sender: Any) {
        saveFavorite(title: comics!.title, num: comics!.num, img: comics!.img)
    }
    
    func saveFavorite(title: String, num: Int, img: String){
        let newFavorite = FavoriteComicsList(context: self.context)
        newFavorite.title = comics!.title
        newFavorite.num = Int16(comics!.num)
        newFavorite.img = comics!.img
        
        do {
            try context.save()
            print("saved favorite \(comics!.title)")
        }
        catch {
            print(error.localizedDescription)
        }
    }
}

extension ComicsView : ComicsManagerDelegate{
    func updateComics(_ comicsManager: ComicsManager, comic: ComicsModel){
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
    func failWithError(error: Error){
        print("Can't fetch comic")
        print(error.localizedDescription)
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "No comic by that number", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
