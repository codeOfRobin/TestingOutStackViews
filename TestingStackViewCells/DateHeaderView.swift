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
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		titleLabel.frame = CGRect.init(x: titleInsets.left, y: titleInsets.top, width: self.frame.width - titleInsets.left - titleInsets.right, height: self.frame.height - titleInsets.top - titleInsets.bottom)
	}

	override var intrinsicContentSize: CGSize {
		return sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
	}

	override func sizeThatFits(_ size: CGSize) -> CGSize {
		let fittingSize = titleLabel.sizeThatFits(_:size)
		return CGSize(width: fittingSize.width + titleInsets.right + titleInsets.left, height: fittingSize.height + titleInsets.top + titleInsets.bottom)
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
