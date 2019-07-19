//
//  ContributorsTableViewController.swift
//  GitHubProofConcept
//
//  Created by Developer on 18/7/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData

class ContributorsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ContributorsTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "reuseIdentifier")
        performFetch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    lazy var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> = {
        if let appDelegate =
            UIApplication.shared.delegate as? AppDelegate {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Contributor.self))
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "login", ascending: true, selector: #selector(NSString.caseInsensitiveCompare))]
            let fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            return fetchResultController
        }
        return NSFetchedResultsController()
    }()
    
    func performFetch() {
        do {
            try self.fetchedResultsController.performFetch()
        } catch let error  {
            print("ERROR: \(error)")
        }
    }
}

extension ContributorsTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = fetchedResultsController.sections?.first?.numberOfObjects {
            return count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! ContributorsTableViewCell
        if let contributor = fetchedResultsController.object(at: indexPath) as? ContributorMO {
            cell.setContributorCellWith(contributor: contributor)
        }
        return cell
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let contributor = fetchedResultsController.object(at: indexPath) as? ContributorMO
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "contributorDetailVC") as? ContributorDetailViewController {
            viewController.contributor = contributor
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
}
