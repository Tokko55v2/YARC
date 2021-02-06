//
//  CoreDataService.swift
//  RedditClient
//
//  Created by Michael Kroneder on 04/02/2021.
//

import CoreData
import Foundation

class CoreDataService: ObservableObject {
    var imageCacher = ImageCache.getImageCache()

    func addSubRedditsToProfile(temp: SubReddit, moc: NSManagedObjectContext) {
        let newYarcSubReddit = YarcProfile(context: moc)

        newYarcSubReddit.bannerBackgroundColor = temp.banner_background_color
        newYarcSubReddit.displayName = temp.display_name
        newYarcSubReddit.displayNamePrefixed = temp.display_name_prefixed
        newYarcSubReddit.iconImg = temp.icon_img
        newYarcSubReddit.over18 = temp.over18
        newYarcSubReddit.primaryColor = temp.primary_color
        newYarcSubReddit.publicDescription = temp.public_description
        newYarcSubReddit.subredditType = temp.subreddit_type
        newYarcSubReddit.subscribers = temp.subscribers
        newYarcSubReddit.title = temp.title
        newYarcSubReddit.url = temp.url

        newYarcSubReddit.iconImageData = imageCacher.get(forKey: temp.icon_img)

        saveContext(moc)
    }

    private func saveContext(_ moc: NSManagedObjectContext) {
        do {
            try moc.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
}

extension YarcProfile {
    static var yarcFetchRequest: NSFetchRequest<YarcProfile> {
        let request: NSFetchRequest<YarcProfile> = YarcProfile.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \YarcProfile.subscribers, ascending: false)]

        return request
    }
}
