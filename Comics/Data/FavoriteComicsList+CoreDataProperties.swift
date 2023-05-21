//
//  FavoriteComicsList+CoreDataProperties.swift
//  Comics
//
//  Created by Ida Anseth  on 21/05/2023.
//
//

import Foundation
import CoreData


extension FavoriteComicsList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteComicsList> {
        return NSFetchRequest<FavoriteComicsList>(entityName: "FavoriteComicsList")
    }

    @NSManaged public var title: String?
    @NSManaged public var img: String?
    @NSManaged public var num: Int16

}

extension FavoriteComicsList : Identifiable {

}
