//
//  EventTimingView.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 13/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import UIKit


class EventTimingView: UIView {
	let stackView = UIStackView()
	let startingTimeView = UILabel()
	let durationLabel = UILabel()


	override init(frame: CGRect) {
		super.init(frame: frame)

		self.addSubview(stackView)

		self.stackView.distribution = .fillProportionally



		self.stackView.translatesAutoresizingMaskIntoConstraints = false
		self.stackView.axis = .vertical
		NSLayoutConstraint.activate([
			self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			self.stackView.topAnchor.constraint(equalTo: self.topAnchor),
			self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
		])
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(with timing: EventViewModel.EventTiming) {
		// DO I NEED TO DO THIS?
		//		self.stackView.arrangedSubviews.forEach(self.stackView.removeArrangedSubview)
		switch timing {
		case .allDay:
			self.stackView.addArrangedSubview(startingTimeView)
			self.startingTimeView.attributedText = NSAttributedString(string: Constants.Strings.allDay, attributes: Styles.Text.StartingTimeStyle)
		case .timed(startingTime: let startingTime, duration: let duration):
			self.stackView.addArrangedSubview(startingTimeView)
			self.stackView.addArrangedSubview(durationLabel)
			self.startingTimeView.attributedText = NSAttributedString(string: startingTime, attributes: Styles.Text.StartingTimeStyle)
			self.durationLabel.attributedText = NSAttributedString(string: duration, attributes: Styles.Text.DurationStyle)
		}
	}
}
