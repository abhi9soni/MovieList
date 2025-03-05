//
//  FavoriteMovie+CoreDataProperties.swift
//  
//
//  Created by Abhinav Soni on 05/03/25.
//
//

import Foundation
import CoreData


extension FavoriteMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovie> {
        return NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
    }

    @NSManaged public var backdropPath: String?
    @NSManaged public var movieId: Int64
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?

}
