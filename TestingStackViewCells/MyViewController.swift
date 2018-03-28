//
//  MyViewController.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 15/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import Foundation
import UIKit

class MyViewController : UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {

	let avatars: [Attendee.Avatar] = [.image(#imageLiteral(resourceName: "AC")), .image(#imageLiteral(resourceName: "NM2")), .image(#imageLiteral(resourceName: "NM")), .image(#imageLiteral(resourceName: "JD"))]

	var staticEventsDataSet: [Date: [EventViewModel]] = [:]
	//TODO: Needs to be var for midnight date changing reasons
	var today = Date()

	let calendar = Calendar(identifier: .gregorian)
	//mutating a `DateFormatter` is just as expensive as creating one, because changing the calendar, timezone, locale, or format causes new stuff to be loaded
	//the cost of `DateFormatter` comes from it loading up the formatting and region information from ICU
	let headerDateFormatter = DateFormatter()

	var offsets = -100...100

	let tableView = UITableView()
	let collectionView: UICollectionView
	let layout = MonthFlowLayout()

	init() {
		self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		headerDateFormatter.dateStyle = .medium


		let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
		let attendees = (avatars + avatars + avatars + avatars).enumerated().map{ Attendee(name: "Attendee \($0)", avatar: $1) }
		staticEventsDataSet[today] = [
			EventViewModel(title: "Chaitra Sukhaldi", timing: .allDay, eventHighlightColor: .orange, attendees: [], location: nil),
			EventViewModel(title: "Spring Team Social", timing: .timed(startingTime: "2:00 PM", duration: "30m"), eventHighlightColor: .green, attendees: attendees, location: "Kayako Gurgaon Alpha")
		]

		staticEventsDataSet[tomorrow] = [
			EventViewModel(title: "Treat friends(esp AC and JDP) to 🌮", timing: .allDay, eventHighlightColor: .orange, attendees: [], location: nil)
		]

		tableView.dataSource = self
		tableView.register(EventCell.self, forCellReuseIdentifier: "eventCell")
		tableView.register(EmptyEventsTableViewCell.self, forCellReuseIdentifier: "emptyEventsCell")
		tableView.register(DateHeaderView.self, forHeaderFooterViewReuseIdentifier: "header")
		tableView.delegate = self
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.sectionHeaderHeight = UITableViewAutomaticDimension
		tableView.tableFooterView = UIView()

		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.register(DayCell.self, forCellWithReuseIdentifier: "cell")
		collectionView.backgroundColor = .white

		tableView.scrollToRow(at: IndexPath(row: 0, section: offsets.count/2), at: .middle, animated: true)
		view.backgroundColor = .white
		view.addSubview(tableView)
		view.addSubview(collectionView)

	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		let width = view.bounds.width - view.safeAreaInsets.left - view.safeAreaInsets.right
		collectionView.frame = CGRect(x: view.safeAreaInsets.left, y: view.safeAreaInsets.top, width: width, height: width)
		tableView.frame = CGRect(x: collectionView.frame.minX, y: collectionView.frame.maxY, width: width, height: view.bounds.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - width)
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? DateHeaderView,
		let date = dateFrom(offset: section) else {
			return nil
		}
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .medium
		header.configure(title: headerDateFormatter.string(from: date))
		return header
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return offsets.count
	}

	func dateFrom(offset: Int) -> Date? {
		if let offset = offsets.element(at: offset),
			let date = calendar.date(byAdding: .day, value: offset, to: today) {
			return date
		} else {
			return nil
		}
	}

	func eventsFromDataset(at index: Int) -> [EventViewModel] {
		if let date = dateFrom(offset: index),
			let events = staticEventsDataSet[date] {
			return events
		} else {
			return []
		}
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let events = eventsFromDataset(at: section)
		if events.count > 0 {
			return events.count
		} else {
			return 1
		}
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let events = eventsFromDataset(at: indexPath.section)

		if events.count > 0 {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventCell else {
				return UITableViewCell()
			}
//			let attendees = (avatars + avatars + avatars + avatars).map{ Attendee(name: "Attendee \(indexPath.row)", avatar: $0) }
//			cell.configure(with: EventViewModel(title: "title + \(indexPath.row)", timing: .timed(startingTime: "6:00 pmasdjfhbsjdfhb", duration: "2h"), eventHighlightColor: .orange, attendees: attendees, location: "location \(indexPath.row)"))
			cell.configure(with: events[indexPath.row])
			return cell
		} else {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: "emptyEventsCell", for: indexPath) as? EmptyEventsTableViewCell else {
				return UITableViewCell()
			}
			cell.configure(text: Constants.Strings.noEvents)
			return cell
		}
	}


	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return offsets.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DayCell else {
			return UICollectionViewCell()
		}
		cell.configure(with: indexPath.row % 30, month: "Mar")
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: Int(collectionView.frame.width/7), height: Int(collectionView.frame.width/7))
	}

}

extension Collection {
	func element(at offset: IndexDistance) -> Element? {
		let optionalIndex = self.index(self.startIndex, offsetBy: offset, limitedBy: endIndex)
		guard let index = optionalIndex else { return nil }
		return self[index]
	}
}


extension UIView {
	func alignEdges(to otherView: UIView, insets: UIEdgeInsets = .zero) {
		self.topAnchor.constraint(equalTo: otherView.topAnchor, constant: insets.top).isActive = true
		self.bottomAnchor.constraint(equalTo: otherView.bottomAnchor, constant: -insets.bottom).isActive = true
		self.leftAnchor.constraint(equalTo: otherView.leftAnchor, constant: insets.left).isActive = true
		self.rightAnchor.constraint(equalTo: otherView.rightAnchor, constant: -insets.right).isActive = true
	}
}
