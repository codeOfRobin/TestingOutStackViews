//
//  MyViewController.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 15/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import Foundation
import UIKit

class MyViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
	let avatars: [Attendee.Avatar] = [.image(#imageLiteral(resourceName: "AC")), .image(#imageLiteral(resourceName: "NM2")), .image(#imageLiteral(resourceName: "NM")), .image(#imageLiteral(resourceName: "JD"))]

	let tableView = UITableView()

	override func viewDidLoad() {
		super.viewDidLoad()

		tableView.dataSource = self
		tableView.register(EventCell.self, forCellReuseIdentifier: "cell")
		tableView.delegate = self
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 40.0
		view.addSubview(tableView)

	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		tableView.frame = view.bounds
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? EventCell else {
			return UITableViewCell()
		}

		let attendees = (avatars + avatars + avatars + avatars).map{ Attendee(name: "Attendee \(indexPath.row)", avatar: $0) }
		cell.configure(with: EventViewModel(title: "title + \(indexPath.row)", timing: .allDay, eventHighlightColor: .orange, attendees: attendees, location: "location \(indexPath.row)"))
		return cell
	}

}

class LocationView: UIView {
	let label = UILabel()
	let image = UIImageView()
	let stackView = UIStackView()

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.addSubview(stackView)
		stackView.addArrangedSubview(image)
		stackView.addArrangedSubview(label)

		image.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
		image.widthAnchor.constraint(equalToConstant: 20.0).isActive = true

		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
		stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
	}

	override var intrinsicContentSize: CGSize {
		return CGSize.init(width: 375, height: 20.0)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(locationName: String) {
		let attrs: [NSAttributedStringKey: Any] = [
			NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: .subheadline),
			NSAttributedStringKey.foregroundColor: UIColor.black
		]
		label.attributedText = NSAttributedString(string: locationName, attributes: attrs)
		label.numberOfLines = 0
		image.image = #imageLiteral(resourceName: "AC")
	}
}

extension UIView {
	func alignEdges(to otherView: UIView) {
		self.topAnchor.constraint(equalTo: otherView.topAnchor).isActive = true
		self.bottomAnchor.constraint(equalTo: otherView.bottomAnchor).isActive = true
		self.leftAnchor.constraint(equalTo: otherView.leftAnchor).isActive = true
		self.rightAnchor.constraint(equalTo: otherView.rightAnchor).isActive = true
	}
}

class EventCell: UITableViewCell {

	let mainStackView = UIStackView()
	let dotView = DotView()
	let eventDetailsView = EventDetailsView(frame: .zero)
	let eventTimingView = EventTimingView(frame: .zero)

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.contentView.addSubview(mainStackView)

		self.mainStackView.addArrangedSubview(eventTimingView)
		self.mainStackView.addArrangedSubview(dotView)
		self.mainStackView.addArrangedSubview(eventDetailsView)

		eventDetailsView.translatesAutoresizingMaskIntoConstraints = false
		dotView.translatesAutoresizingMaskIntoConstraints = false
		mainStackView.translatesAutoresizingMaskIntoConstraints = false
		self.mainStackView.alignEdges(to: self.contentView)

		dotView.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
		dotView.widthAnchor.constraint(equalToConstant: 20.0).isActive = true

		eventTimingView.widthAnchor.constraint(greaterThanOrEqualToConstant: 70.0)

		self.mainStackView.alignment = .firstBaseline

		self.mainStackView.spacing = 10.0

		self.mainStackView.distribution = .fillProportionally
	}


	override func layoutSubviews() {
		super.layoutSubviews()
	}
	func configure(with event: EventViewModel) {
		self.dotView.configure(color: .orange)
		self.eventDetailsView.configure(with: event.attendees.map{ $0.avatar }, eventTitle: event.title + event.title + event.title + event.title, eventLocation: event.location)

		let attrs: [NSAttributedStringKey: Any] = [
			NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: .subheadline),
			NSAttributedStringKey.foregroundColor: UIColor.black
		]
		self.eventTimingView.configure(with: .allDay)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

class EventDetailsView: UIView {

	let presenceView = PresenceView(frame: .zero)
	let stackView = UIStackView()
	let label = UILabel()
	let locationView = LocationView(frame: .zero)
	let dotView = DotView(frame: .zero)

	override init(frame: CGRect) {
		super.init(frame: frame)

		self.addSubview(stackView)
		stackView.axis = .vertical
		stackView.addArrangedSubview(label)
		stackView.addArrangedSubview(presenceView)
		stackView.addArrangedSubview(locationView)
		presenceView.translatesAutoresizingMaskIntoConstraints = false
		label.translatesAutoresizingMaskIntoConstraints = false
		stackView.translatesAutoresizingMaskIntoConstraints = false


		label.numberOfLines = 0

		stackView.spacing = 20.0
		stackView.alignEdges(to: self)
	}

	func configure(with avatars: [Attendee.Avatar], eventTitle: String, eventLocation: String?) {
		presenceView.configure(with: avatars)
		let attrs: [NSAttributedStringKey: Any] = [
			NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: .subheadline),
			NSAttributedStringKey.foregroundColor: UIColor.black
		]
		label.attributedText = NSAttributedString.init(string: eventTitle + eventTitle + eventTitle + eventTitle + eventTitle + eventTitle + eventTitle, attributes: attrs)
		if let locationString = eventLocation {
			locationView.configure(locationName: locationString + locationString + locationString)
		}
	}

	override func layoutSubviews() {
		super.layoutSubviews()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

class DotView: UIView {
	override init(frame: CGRect) {
		super.init(frame: frame)

		self.clipsToBounds = true
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(color: UIColor) {
		self.backgroundColor = color
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		self.layer.cornerRadius = frame.height/2
	}

	override var intrinsicContentSize: CGSize {
		return CGSize.init(width: 20.0, height: 20.0)
	}

	override func sizeThatFits(_ size: CGSize) -> CGSize {
		return CGSize.init(width: 20.0, height: 20.0)
	}
}
