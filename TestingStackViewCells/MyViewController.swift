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
		tableView.register(PresenceStackViewCell.self, forCellReuseIdentifier: "cell")
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
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PresenceStackViewCell else {
			return UITableViewCell()
		}
		cell.configure(with: avatars + avatars + avatars, eventTitle: "title + \(indexPath.row)", eventLocation: "location \(indexPath.row)")
		return cell
	}

}

class PresenceALCell: UITableViewCell {
	let presenceView = PresenceView(frame: .zero)

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.contentView.addSubview(presenceView)
		self.presenceView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
		self.presenceView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
		self.presenceView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
		self.presenceView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
	}

	func configure(with avatars: [Attendee.Avatar]) {
		presenceView.configure(with: avatars)
	}

	override func layoutSubviews() {
		super.layoutSubviews()
	}


	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

class PresenceStackViewCell: UITableViewCell {

	let presenceView = PresenceView(frame: .zero)
	let stackView = UIStackView()
	let label = UILabel()
	let label2 = UILabel()

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.contentView.addSubview(stackView)
		stackView.axis = .vertical
		stackView.addArrangedSubview(label)
		stackView.addArrangedSubview(presenceView)
		stackView.addArrangedSubview(label2)
		presenceView.translatesAutoresizingMaskIntoConstraints = false
		label.translatesAutoresizingMaskIntoConstraints = false
		stackView.translatesAutoresizingMaskIntoConstraints = false


		label.numberOfLines = 0
		label2.numberOfLines = 0

		stackView.spacing = 20.0

		stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
		stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
		stackView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
		stackView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
	}

	func configure(with avatars: [Attendee.Avatar], eventTitle: String, eventLocation: String) {
		presenceView.configure(with: avatars)
		let attrs: [NSAttributedStringKey: Any] = [
			NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: .subheadline),
			NSAttributedStringKey.foregroundColor: UIColor.black
		]
		label.attributedText = NSAttributedString.init(string: eventTitle + eventTitle + eventTitle + eventTitle + eventTitle + eventTitle + eventTitle, attributes: attrs)
		label2.attributedText = NSAttributedString(string: eventLocation + eventLocation + eventLocation + eventLocation + eventLocation + eventLocation, attributes: attrs)
	}

	override func layoutSubviews() {
		super.layoutSubviews()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
