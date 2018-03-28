//
//  DayCell.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 28/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import UIKit

protocol DateComponentsPresenter {
	func shortMonthText(with components: DateComponents) -> String?
	func dayText(with components: DateComponents) -> String?
}

class GregorianDateComponentsPresenter: DateComponentsPresenter {

	let calendar: Calendar = Calendar(identifier: .gregorian)

	func shortMonthText(with components: DateComponents) -> String? {
		return components.day.flatMap{ calendar.shortStandaloneMonthSymbols[$0] }
	}

	func dayText(with components: DateComponents) -> String? {
		return components.day.flatMap{ "\($0)" }
	}
}

class DayCell: UICollectionViewCell {
	let dayLabel = UILabel()
	let monthLabel = UILabel()
	let stackView = UIStackView()

	override init(frame: CGRect) {
		super.init(frame: frame)

		contentView.addSubview(stackView)
		stackView.alignEdges(to: contentView)

		stackView.axis = .vertical

		stackView.translatesAutoresizingMaskIntoConstraints = false

		stackView.addArrangedSubview(monthLabel)
		stackView.addArrangedSubview(dayLabel)

		self.dayLabel.textAlignment = .center
		self.monthLabel.textAlignment = .center

	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()
	}

	// still confused what this should look like 😕. Should this accept DateComponents? Should month not be optional? SHould the logic for not showing the month label not be inside the cell? It def shouldn't have a Date
	func configure(with day: Int, month: String?) {
		self.backgroundColor = .white

		if day == 1 {
			self.monthLabel.text = month
			self.monthLabel.isHidden = false
		} else {
			self.monthLabel.isHidden = true
		}
		self.dayLabel.text = "\(day)"

	}
}

