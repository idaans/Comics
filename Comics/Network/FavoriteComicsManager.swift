//
//  FavoriteComicsManager.swift
//  Comics
//
//  Created by Ida Anseth  on 21/05/2023.
//

import Foundation
import UIKit

class FavoriteComicsManager {
    
    // Fetching context from container
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Fetching favorites from saved list
    func getAllFavorites(){
        do {
            let comics = try context.fetch(FavoriteComicsList.fetchRequest())
        }
        catch {
            //error
        }
    }
    
    // Saving favorite with items in coredata
    func saveFavoriteComic(title: String, img: String, num: Int){
        let newFavorite = FavoriteComicsList(context: context)
        newFavorite.title = title
        newFavorite.img = img
        newFavorite.num = Int16(num)
    }
    
    // Delete comic from FavoriteComicsList in coredata
    func deleteFavoriteComic(favoriteComic: FavoriteComicsList){
        context.delete(favoriteComic)
    }
}
