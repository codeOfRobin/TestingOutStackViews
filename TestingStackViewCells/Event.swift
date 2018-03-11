//
//  Event.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 10/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import UIKit

struct Event {

	/// Events can be either All-Day or from a specific time spanning a duration
	enum EventTiming {
		case allDay
		case timed(startingTime: Date, duration: TimeInterval)
	}

	/// The title of the event
	let title: String

	let timing: EventTiming

	/// The color of the "dot" in the UI. I couldn't quite grok what they meant (some of them displayed with icons for birthdays, skype calls etc), but I couldn't figure out what they represented. In an ideal scenario, this'd be an enum with that information represented
	let eventHighlightColor: UIColor

	let attendees: [Attendee]

	/// The locaiton of the event. It's a string for now, but in a real-world app probably has lots of location metadata around it
	let location: String?

}

struct Attendee {
	let name: String

	enum Avatar {
		case image(UIImage)
		case url(URL)
	}

	let avatar: Avatar
}

class EventTableViewCell: UITableViewCell {

	let stackView = UIStackView()
	let leftLabel = UILabel()
	let rightLabel = UILabel()

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		self.contentView.addSubview(stackView)
		self.leftLabel.numberOfLines = 0
		self.rightLabel.numberOfLines = 0
		self.stackView.addArrangedSubview(leftLabel)
		self.stackView.addArrangedSubview(rightLabel)

		NSLayoutConstraint.activate([
			self.stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16.0),
			self.stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16.0),
			self.stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12.0),
			self.stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12.0)
		])

		self.stackView.translatesAutoresizingMaskIntoConstraints = false
	}

	func configure(with event: Event) {
		self.rightLabel.text = "Most angery pupper I have ever seen pupper much ruin diet doggorino, floofs."
		self.leftLabel.text = "Doggo ipsum thicc wow very biscit puggo very hand that feed shibe, fluffer"
		self.layoutIfNeeded()
	}


	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


//class InsettedTableViewCell: UITableViewCell {
//	var wrappedView = UIView() {
//		didSet {
//			oldValue.removeFromSuperview()
//			self.addSubview(wrappedView)
//		}
//	}
//
//	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//		super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//		self.addSubview(wrappedView)
//	}
//
//	required init?(coder aDecoder: NSCoder) {
//		fatalError("init(coder:) has not been implemented")
//	}
//
//	func configure(with view: UIView) {
//
//		contentNode.addSubview(contentView)
//		contentNode.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 12.0)
//	}
//}

