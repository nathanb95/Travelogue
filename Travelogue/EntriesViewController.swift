//
//  EntriesViewController.swift
//  Travelogue
//
//  Created by Nathaniel Banderas on 7/27/18.
//  Copyright © 2018 Nathaniel Banderas. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class EntriesViewController: UIViewController {

    @IBOutlet weak var entriesTableView: UITableView!
    
    let dateFormatter = DateFormatter()
    
    var trip: Trip?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.timeStyle = .long
        dateFormatter.dateStyle = .long

    }

    override func viewWillAppear(_ animated: Bool) {
        self.entriesTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addNewEntry(_ sender: Any) {
        performSegue(withIdentifier: "showEntry", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? NewEntriesViewController else {
            return
        }
        
        destination.trip = trip
    }
    
    func deleteDocument(at indexPath: IndexPath) {
        guard let trip = trip?.trips?[indexPath.row], let managedContext = trip.managedObjectContext else {
            return
        }
        
        managedContext.delete(trip)
        
        do {
            try managedContext.save()
            
            entriesTableView.deleteRows(at: [indexPath], with: .automatic)
        } catch {
            print("Could not delete entry")
            
            entriesTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    
}

extension EntriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trip?.rawEntries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = entriesTableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath) as! UITableViewCell
        
//        if let entry = trip?.rawEntries?[indexPath.row] {
//            cell.textLabel?.text = entry.name
//            cell.detailTextLabel?.text = entry.desc
//        }
//        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteDocument(at: indexPath)
        }
    }
}

extension EntriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showEntry", sender: self)
    }
}


