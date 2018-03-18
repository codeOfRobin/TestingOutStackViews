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
	let presence = PresenceView()
	let avatars: [Attendee.Avatar] = [.image(#imageLiteral(resourceName: "AC")), .image(#imageLiteral(resourceName: "NM2")), .image(#imageLiteral(resourceName: "NM")), .image(#imageLiteral(resourceName: "JD"))]

	let tableView = UITableView()

	override func viewDidLoad() {
		super.viewDidLoad()

//		view.addSubview(presence)
//		presence.configure(with: avatars + avatars + avatars)

		tableView.dataSource = self
		tableView.register(PresenceCell.self, forCellReuseIdentifier: "cell")
		tableView.estimatedRowHeight = UITableViewAutomaticDimension
		view.addSubview(tableView)
	}


	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		tableView.frame = view.bounds
		let presenceSize = presence.sizeThatFits(self.view.bounds.size)
		presence.frame = CGSize(width: presenceSize.width - 40, height: presenceSize.height).centeredVertically(in: self.view.bounds)
//		plusNumberView.frame = CGRect(origin: CGPoint(x: 0, y: 44), size: plusNumberView.sizeThatFits(view.bounds.size))
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PresenceCell else {
			return UITableViewCell()
		}
		cell.configure(with: avatars + avatars + avatars)
		return cell
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100.0
	}

}

class PresenceCell: UITableViewCell {

	let presenceView = PresenceView(frame: .zero)

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.contentView.addSubview(presenceView)
		presenceView.topAnchor.constraint(equalTo: self.contentView.topAnchor)
		presenceView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
		presenceView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor)
		presenceView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
	}

	func configure(with avatars: [Attendee.Avatar]) {
		presenceView.configure(with: avatars)
	}


	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
