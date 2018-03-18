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
		tableView.estimatedRowHeight = UITableViewAutomaticDimension
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
		cell.configure(with: avatars + avatars + avatars)
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

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.contentView.addSubview(stackView)
		stackView.addArrangedSubview(presenceView)
	}

	func configure(with avatars: [Attendee.Avatar]) {
		presenceView.configure(with: avatars)
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		stackView.frame = contentView.bounds
	}

	override func sizeThatFits(_ size: CGSize) -> CGSize {
		return presenceView.intrinsicContentSize
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
