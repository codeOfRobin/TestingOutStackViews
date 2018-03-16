//
//  EventDetailsView.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 14/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import UIKit

class AvatarsView: UIView {
	let stackView = UIStackView()

	var imageViews: [UIImageView] = []

	init() {
		super.init(frame: .zero)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(avatars: [Attendee]) {
		self.imageViews.forEach{ $0.removeFromSuperview() }

		self.imageViews = avatars.flatMap { (attendee) in
			if case .image(let image) = attendee.avatar {
				return UIImageView(image: image)
			} else {
				return nil
			}
		}

		self.imageViews.forEach(self.stackView.addArrangedSubview)
	}
}

class EventDetailsView: UIView {

	let stackView = UIStackView()
	let avatarsView = AvatarsView()

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.addSubview(stackView)

	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(viewModel: EventViewModel) {

	}

}
