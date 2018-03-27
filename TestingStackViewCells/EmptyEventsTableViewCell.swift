//
//  EmptyEventsTableViewCell.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 27/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import UIKit

class EmptyEventsTableViewCell: UITableViewCell {

	let label = UILabel()
	//TODO: should this be in the cell or in Styles.swift
	let insets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		self.contentView.addSubview(label)

		//TODO: good place to add constraints?
		label.numberOfLines = 0
		self.addSubview(label)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.alignEdges(to: self.contentView, insets: insets)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(text: String) {
		label.attributedText = NSAttributedString(string: text, attributes: Styles.Text.EmptyEventsStyle)
	}

}
