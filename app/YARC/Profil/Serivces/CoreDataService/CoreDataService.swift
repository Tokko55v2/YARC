//
//  CoreDataService.swift
//
//
//  Created by Michael Kroneder on 14/04/2021.
//
import CoreData
import Foundation
import YARC_SDK

struct CoreDataService {
    func addSubRedditsToProfile(_ item: SubReddit, context moc: NSManagedObjectContext) {
        let newYarcSubReddit = YarcProfile(context: moc)

        newYarcSubReddit.displayName = item.display_name
        newYarcSubReddit.displayNamePrefixed = item.display_name_prefixed
        newYarcSubReddit.over18 = item.over18
        newYarcSubReddit.subredditType = item.subreddit_type
        newYarcSubReddit.subscribers = item.subscribers
        newYarcSubReddit.title = item.title
        newYarcSubReddit.primaryColor = item.primary_color
        newYarcSubReddit.iconImg = item.icon_img
        newYarcSubReddit.publicDescription = item.public_description
        newYarcSubReddit.bannerBackgroundColor = item.banner_background_color

        saveContext(context: moc)
    }

    func deleteSubReddit(_ item: YarcProfile, context moc: NSManagedObjectContext) {
        moc.delete(item)
        saveContext(context: moc)
    }

    private func saveContext(context moc: NSManagedObjectContext) {
        do {
            try moc.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
}
