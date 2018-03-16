//
//  MasterViewController.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 10/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

	var detailViewController: DetailViewController? = nil
	let events = [
		EventViewModel(title: "Service Appointment at BMW OF SAN FRANCISCO", timing: .allDay, eventHighlightColor: .green, attendees: [], location: "1675 HOWARD STREET, SAN FRANCISCO"),
		EventViewModel(title: "Mobile All Hands", timing: .timed(startingTime: "3:00 PM", duration: "1h"), eventHighlightColor: .yellow, attendees: [], location: "Conf Room 1355 Market/350 lots of location text here"),
		EventViewModel(title: "Free Lunch & Speechless Madness!", timing: .allDay, eventHighlightColor: .yellow, attendees: [], location: "Conf Room 1355 Market/350 lots of location text here")
	]


	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		navigationItem.leftBarButtonItem = editButtonItem

		let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
		navigationItem.rightBarButtonItem = addButton
		if let split = splitViewController {
		    let controllers = split.viewControllers
		    detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
		}

		self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
		self.tableView.register(EventTableViewCell.self, forCellReuseIdentifier: "cell")
	}

	override func viewWillAppear(_ animated: Bool) {
		clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
		super.viewWillAppear(animated)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@objc
	func insertNewObject(_ sender: Any) {
//		objects.insert(NSDate(), at: 0)
//		let indexPath = IndexPath(row: 0, section: 0)
//		tableView.insertRows(at: [indexPath], with: .automatic)
	}

	// MARK: - Segues

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//		if segue.identifier == "showDetail" {
//		    if let indexPath = tableView.indexPathForSelectedRow {
//		        let object = events[indexPath.row] as! NSDate
//		        let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
//		        controller.detailItem = object
//		        controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
//		        controller.navigationItem.leftItemsSupplementBackButton = true
//		    }
//		}
	}

	// MARK: - Table View

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return events.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? EventTableViewCell else {
			return UITableViewCell.init()
		}
		cell.configure(with: events[indexPath.row])
		return cell
	}

	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		// Return false if you do not want the specified item to be editable.
		return true
	}

	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
//		    events.remove(at: indexPath.row)
//		    tableView.deleteRows(at: [indexPath], with: .fade)
		} else if editingStyle == .insert {
		    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
		}
	}


}

