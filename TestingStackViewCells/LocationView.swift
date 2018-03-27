//
//  LocationView.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 27/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import UIKit

class LocationView: UIView {
	let label = UILabel()
	let image = UIImageView()

	let margin: CGFloat = 8

	override init(frame: CGRect) {
		super.init(frame: frame)

		self.addSubview(label)
		self.addSubview(image)


		label.translatesAutoresizingMaskIntoConstraints = false
		image.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 1

		NSLayoutConstraint.activate([
			image.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			label.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: margin),
			label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			image.topAnchor.constraint(equalTo: self.topAnchor),
			label.topAnchor.constraint(equalTo: self.topAnchor),
			label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			image.heightAnchor.constraint(equalTo: label.heightAnchor),
			image.widthAnchor.constraint(equalTo: image.heightAnchor)
			])

		image.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
		image.setContentHuggingPriority(.defaultLow, for: .vertical)
		image.contentMode = .scaleAspectFit
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(locationName: String) {
		label.attributedText = NSAttributedString(string: locationName, attributes: Styles.Text.LocationStyle)
		// Location by Ralf Schmitzer from the Noun Project
		image.image = #imageLiteral(resourceName: "Pin")
	}
}
