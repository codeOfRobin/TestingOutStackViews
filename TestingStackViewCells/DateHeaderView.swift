//
//  DateHeaderView.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 27/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

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

		self.backgroundView?.backgroundColor = Styles.Colors.contrastBackgroundColor.color
	}

	func configure(title: String) {
		titleLabel.attributedText = NSAttributedString(string: title, attributes: Styles.Text.DateHeaderStyle)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
