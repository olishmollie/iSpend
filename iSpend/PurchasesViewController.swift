//
//  PurchasesViewController.swift
//  iSpend
//
//  Created by Oliver Duncan on 12/3/16.
//  Copyright © 2016 BondTwins. All rights reserved.
//

import UIKit
import CoreData

class PurchasesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let context: NSManagedObjectContext = DataController.sharedInstance.persistentContainer.viewContext
    
    lazy var fetchedResultsController: NSFetchedResultsController<Purchase> = {
        let request: NSFetchRequest<Purchase> = Purchase.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        return NSFetchedResultsController<Purchase>.init(fetchRequest: request, managedObjectContext: self.context, sectionNameKeyPath: nil, cacheName: nil)
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("An error occurred")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let purchases = fetchedResultsController.fetchedObjects else { return 0 }
        return purchases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PurchasesTableCell")!
        let purchase = fetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = purchase.name
        cell.detailTextLabel?.text = String(purchase.amount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
            case .delete:
                context.delete(fetchedResultsController.object(at: indexPath))
                DataController.sharedInstance.saveContext()
            default: return
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditPurchaseSegue" {
            if let indexPath = tableView.indexPathForSelectedRow,
            let destination = segue.destination as? EditPurchaseViewController {
                let purchase = fetchedResultsController.object(at: indexPath)
                destination.purchase = purchase
            }
        }
    }

}

extension PurchasesViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            case .delete:
                tableView.deleteRows(at: [indexPath!], with: .automatic)
            case .insert:
                tableView.insertRows(at: [newIndexPath!], with: .automatic)
            default: return
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
}
