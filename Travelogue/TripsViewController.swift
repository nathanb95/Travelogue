//
//  CategoriesViewController.swift
//  Travelogue
//
//  Created by Nathaniel Banderas on 7/27/18.
//  Copyright © 2018 Nathaniel Banderas. All rights reserved.
//

import UIKit
import CoreData

class TripsViewController: UIViewController {

    @IBOutlet weak var tripTableView: UITableView!
    
    var trips: [Trip] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? EntriesViewController, let selectedRow = self.tripTableView.indexPathForSelectedRow?.row else {
            return
        }
        
        destination.trip = trips[selectedRow]
    }
    
    func deleteTrip(at indexPath: IndexPath) {
        let trip = trips[indexPath.row]
        
        guard let managedContext = trip.managedObjectContext else {
            return
        }
        
        managedContext.delete(trip)
        
        do {
            try managedContext.save()
            
            trips.remove(at: indexPath.row)
            tripTableView.deleteRows(at: [indexPath], with: .automatic)
        } catch {
            print("Could not delete")
            
            tripTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Trip> = Trip.fetchRequest()
        
        do {
            trips = try managedContext.fetch(fetchRequest)
            tripTableView.reloadData()
        } catch {
            print("Could not fetch")
        }
    }
    
}

extension TripsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tripTableView.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath)
        let trip = trips[indexPath.row]
        
        cell.textLabel?.text = trip.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteTrip(at: indexPath)
        }
    }
}
