//
//  MyViewController.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 15/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import Foundation
import UIKit

class DateHeaderView: UITableViewHeaderFooterView {
	let titleLabel = UILabel()

	let titleInsets = UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16)

	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		titleLabel.numberOfLines = 0
		self.addSubview(titleLabel)
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.alignEdges(to: self, insets: titleInsets)
	}

	func configure(title: String) {
		titleLabel.attributedText = NSAttributedString(string: title, attributes: Styles.Text.DateHeaderStyle)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

class MyViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
	let avatars: [Attendee.Avatar] = [.image(#imageLiteral(resourceName: "AC")), .image(#imageLiteral(resourceName: "NM2")), .image(#imageLiteral(resourceName: "NM")), .image(#imageLiteral(resourceName: "JD"))]

	let tableView = UITableView()

	override func viewDidLoad() {
		super.viewDidLoad()

		tableView.dataSource = self
		tableView.register(EventCell.self, forCellReuseIdentifier: "cell")
		tableView.register(DateHeaderView.self, forHeaderFooterViewReuseIdentifier: "header")
		tableView.delegate = self
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.sectionHeaderHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 40.0
		view.addSubview(tableView)

	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		tableView.frame = CGRect.init(x: view.safeAreaInsets.left, y: view.safeAreaInsets.top, width: view.bounds.width - view.safeAreaInsets.left - view.safeAreaInsets.right, height: view.bounds.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? DateHeaderView else {
			return nil
		}
		header.configure(title: "title \(section)")
		return header
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return 10
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 2
	}


	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? EventCell else {
			return UITableViewCell()
		}

		let attendees = (avatars + avatars + avatars + avatars).map{ Attendee(name: "Attendee \(indexPath.row)", avatar: $0) }
		cell.configure(with: EventViewModel(title: "title + \(indexPath.row)", timing: .timed(startingTime: "6:00 pmasdjfhbsjdfhb", duration: "2h"), eventHighlightColor: .orange, attendees: attendees, location: "location \(indexPath.row)"))
		return cell
	}

}

class LocationView: UIView {
	let label = UILabel()
	let image = UIImageView()

	let margin: CGFloat = 8

	override init(frame: CGRect) {
		super.init(frame: frame)

		self.addSubview(label)
		self.addSubview(image)


		label.translatesAutoresizingMaskIntoConstraints = false
		image.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 1

		NSLayoutConstraint.activate([
			image.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			label.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: margin),
			label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			image.topAnchor.constraint(equalTo: self.topAnchor),
			label.topAnchor.constraint(equalTo: self.topAnchor),
			label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			image.heightAnchor.constraint(equalTo: label.heightAnchor),
			image.widthAnchor.constraint(equalTo: image.heightAnchor)
		])

		image.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
		image.setContentHuggingPriority(.defaultLow, for: .vertical)
		image.contentMode = .scaleAspectFit
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(locationName: String) {
		label.attributedText = NSAttributedString(string: locationName, attributes: Styles.Text.LocationStyle)
		// Location by Ralf Schmitzer from the Noun Project
		image.image = #imageLiteral(resourceName: "Pin")
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

		eventTimingView.widthAnchor.constraint(equalToConstant: 80.0).isActive = true

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
		self.eventTimingView.configure(with: event.timing)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

class EventDetailsView: UIView {

	let presenceView = PresenceView(frame: .zero)
	let stackView = UIStackView()
	let titleLabel = UILabel()
	let locationView = LocationView(frame: .zero)
	let dotView = DotView(frame: .zero)

	override init(frame: CGRect) {
		super.init(frame: frame)

		self.addSubview(stackView)
		stackView.axis = .vertical
		stackView.addArrangedSubview(titleLabel)
		stackView.addArrangedSubview(presenceView)
		stackView.addArrangedSubview(locationView)
		presenceView.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		stackView.translatesAutoresizingMaskIntoConstraints = false


		titleLabel.numberOfLines = 0

		stackView.spacing = 20.0
		stackView.alignEdges(to: self)
	}

	func configure(with avatars: [Attendee.Avatar], eventTitle: String, eventLocation: String?) {
		presenceView.configure(with: avatars)
		titleLabel.attributedText = NSAttributedString(string: eventTitle + eventTitle + eventTitle + eventTitle + eventTitle + eventTitle + eventTitle, attributes: Styles.Text.EventTitleStyle)
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
