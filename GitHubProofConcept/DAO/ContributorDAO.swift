//
//  File.swift
//  GitHubProofConcept
//
//  Created by Developer on 18/7/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ContributorDAO {
    
    public static func save(contributor: Contributor) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Contributor", in: context)
        if let entity = entity {
            if let contributorMO = getFirstByLogin(login: contributor.login) {
               setContributorValues(contributorMO: contributorMO, contributor: contributor)
            } else {
               let contributorMO = ContributorMO(entity: entity, insertInto: context)
               setContributorValues(contributorMO: contributorMO, contributor: contributor)
            }
            appDelegate.saveContext()
        }
    }
    
    private static func setContributorValues(contributorMO: ContributorMO, contributor: Contributor) {
        contributorMO.setValue(contributor.login, forKeyPath: "login")
        contributorMO.setValue(contributor.avatar_url, forKey: "avatar_url")
        contributorMO.setValue(contributor.name, forKey: "name")
        contributorMO.setValue(contributor.email, forKey: "email")
    }
    
    private static func getFirstByLogin(login: String) -> ContributorMO? {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return nil
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ContributorMO>(entityName: "Contributor")
        fetchRequest.predicate = NSPredicate(format: "login == %@ ", login)
        do {
            let fetchResult = try context.fetch(fetchRequest)
            return fetchResult.first
        } catch let error as NSError {
            
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
}
