//
//  MyViewController.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 15/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import Foundation
import UIKit

class PresenceView: UIView {
	private var circles: [CircularAvatar] = []
	let margin: CGFloat = 8

	// might as well initialize it cos you're gonna need it for sizing later
	let plusNumberView = PlusNumberView(frame: .zero)

	override init(frame: CGRect) {
		super.init(frame: frame)

		self.addSubview(plusNumberView)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func sizeThatFits(_ size: CGSize) -> CGSize {
		let minimumHeight = plusNumberView.sizeThatFits(size).height
		return CGSize(width: size.width, height: minimumHeight)
	}

	override var intrinsicContentSize: CGSize {
		let circleSize = circles.first?.sizeThatFits(self.frame.size) ?? CGSize.init(width: margin, height: margin)
		return CGSize.init(width: CGFloat(circles.count) * (margin + circleSize.width) + margin , height: circleSize.height)
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		let frame = self.frame

		let circleSize = circles.first?.sizeThatFits(self.frame.size) ?? CGSize.init(width: margin, height: margin)

		let numberOfAvatarsToFit = Int((frame.width - margin)/circleSize.width) - 1

		circles.enumerated().forEach { arg in
			let (index, circle) = arg
			circle.frame = circleSize.centeredVertically(in: self.bounds, left: frame.minX + margin + CGFloat(index) * (circleSize.width + margin))
			circle.alpha = (index >= numberOfAvatarsToFit - 1) ? 0.0 : 1.0
		}

		let extraAvatars = circles.count - numberOfAvatarsToFit

		self.plusNumberView.alpha = extraAvatars > 0 ? 1.0 : 0.0

		if extraAvatars > 0 {
			plusNumberView.configure(with: circles.count - numberOfAvatarsToFit)
			let leftover = self.frame.width - CGFloat(numberOfAvatarsToFit) * circleSize.width
			let lastCircleFrame = (circles.prefix(numberOfAvatarsToFit - 1).last?.frame ?? .zero)
			let plusNumberSize = plusNumberView.sizeThatFits(CGSize.init(width: leftover, height: circleSize.height))
			plusNumberView.frame = plusNumberSize.centeredVertically(in: self.bounds, left: lastCircleFrame.maxX + margin)
		}

	}

	func configure(with avatars: [Attendee.Avatar]) {

		self.circles.forEach { $0.removeFromSuperview() }
		let newCircles: [CircularAvatar] = avatars.flatMap { (avatar) in
			switch avatar {
			case .image(let image):
				return CircularAvatar(image: image)
			case .initials(let char1, let char2):
				return nil
			}
		}

		newCircles.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
		newCircles.forEach { self.addSubview($0) }
		self.circles = newCircles
		self.setNeedsLayout()
	}
}

class MyViewController : UIViewController {
	let presence = PresenceView()

	let plusNumberView = PlusNumberView(frame: .zero)
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
//		plusNumberView.frame = CGRect(origin: CGPoint(x: 0, y: 44), size: plusNumberView.sizeThatFits(view.bounds.size))
	}
}
