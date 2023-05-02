//
//  ComicsView.swift
//  Comics
//
//  Created by Ida Anseth  on 01/05/2023.
//

import Foundation
import UIKit

class ComicsView: UIViewController {
    
    //Fetching with manager
    var comicsManager = ComicsManager()
    //Fetching with model
    var comics: ComicsModel?
    var comicNumber = 1
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchComics()
    }
    
    func fetchComics(){
        let number = String(comicNumber)
        comicsManager.fetchComics(number: number)
        print("Fetching comic number: \(number)")
    }
    
}
