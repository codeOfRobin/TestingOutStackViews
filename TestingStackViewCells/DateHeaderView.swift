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

	let stackView = UIStackView()

	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		titleLabel.numberOfLines = 0
		self.addSubview(stackView)
		stackView.addArrangedSubview(titleLabel)
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.alignEdges(to: self, insets: titleInsets)
	}

	func configure(title: String, shouldHighlight: Bool) {
		// https://stackoverflow.com/questions/15604900/uitableviewheaderfooterview-unable-to-change-background-color
		self.backgroundView = UIView(frame: self.bounds)
		if shouldHighlight {
			titleLabel.attributedText = NSAttributedString(string: title, attributes: Styles.Text.HighlightedDateHeaderStyle)
			self.backgroundView?.backgroundColor = Styles.Colors.Today.highlightBackgroundColor.color
		} else {
			titleLabel.attributedText = NSAttributedString(string: title, attributes: Styles.Text.DateHeaderStyle)
			self.backgroundView?.backgroundColor = Styles.Colors.contrastBackgroundColor.color
		}
		self.setNeedsLayout()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
