//
//  YarcProfile+Extension.swift
//  YARC
//
//  Created by Michael Kroneder on 18/04/2021.
//

import CoreData
import Foundation

extension YarcProfile {
    static var yarcFetchRequest: NSFetchRequest<YarcProfile> {
        let request: NSFetchRequest<YarcProfile> = YarcProfile.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \YarcProfile.subscribers, ascending: false)]

        return request
    }
}
