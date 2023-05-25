//
//  FavoriteComicsManager.swift
//  Comics
//
//  Created by Ida Anseth  on 21/05/2023.
//

import Foundation
import UIKit
import CoreData

class FavoriteComicsManager {
    
    // Fetching context from container
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var favoritesList = [FavoriteComicsList]()
    
    // Fetching favorites from saved list
    func getAllFavorites(){
        do {
            self.favoritesList = try context.fetch(FavoriteComicsList.fetchRequest())
            print("Fetch success")
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    
    // Saving favorite with items in coredata
    func saveFavoriteComic(title: String, img: String, num: Int){
        let newFavorite = FavoriteComicsList(context: context)
        newFavorite.title = title
        newFavorite.img = img
        newFavorite.num = Int16(num)
        
        do {
            try context.save()
        }
        catch {
        }
    }
    
    // Delete comic from FavoriteComicsList in coredata
    func deleteFavoriteComic(favoriteComic: FavoriteComicsList){
        context.delete(favoriteComic)
        do {
            try context.save()
        }
        catch {
        }
    }
}
