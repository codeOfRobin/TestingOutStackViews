//
//  MyNonTableViewController.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 18/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import Foundation

import UIKit

class MyNonTableViewController : UIViewController {
	let presence = PresenceView()
	let avatars: [Attendee.Avatar] = [.image(#imageLiteral(resourceName: "AC")), .image(#imageLiteral(resourceName: "NM2")), .image(#imageLiteral(resourceName: "NM")), .image(#imageLiteral(resourceName: "JD"))]

	override func viewDidLoad() {
		super.viewDidLoad()

		view.addSubview(presence)
		presence.configure(with: avatars + avatars + avatars)
	}


	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		let presenceSize = presence.sizeThatFits(self.view.bounds.size)
		presence.frame = CGSize(width: presenceSize.width - 40, height: presenceSize.height).centeredVertically(in: self.view.bounds)
	}
}
