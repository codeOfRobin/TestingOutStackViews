//
//  MyViewController.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 15/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import Foundation
import UIKit

extension CGSize {
	public func centered(in rect: CGRect) -> CGRect {
		let centeredPoint = CGPoint(x: rect.minX + fabs(rect.width - width) / 2, y: rect.minY + fabs(rect.height - height) / 2)
		let size = CGSize(width: min(self.width, rect.width), height: min(self.height, rect.height))
		let point = CGPoint(x: max(centeredPoint.x, rect.minX), y: max(centeredPoint.y, rect.minY))
		return CGRect(origin: point, size: size)
	}

	public func centeredHorizontally(in rect: CGRect, top: CGFloat = 0) -> CGRect {
		var rect = centered(in: rect)
		rect.origin.y = top
		return rect
	}

	public func centeredVertically(in rect: CGRect, left: CGFloat = 0) -> CGRect {
		var rect = centered(in: rect)
		rect.origin.x = left
		return rect
	}
}

class CircularAvatar: UIImageView {

	override func layoutSubviews() {
		super.layoutSubviews()
		self.clipsToBounds = true
		layer.cornerRadius = bounds.height / 2
	}

	override func sizeThatFits(_ size: CGSize) -> CGSize {
		return CGSize(width: 44, height: 44)
	}
}


func fontWithMonospacedNumbers(_ font: UIFont) -> UIFont {
	let features = [
		[
			UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType,
			UIFontDescriptor.FeatureKey.typeIdentifier: kMonospacedNumbersSelector
		]
	]

	let fontDescriptor = font.fontDescriptor.addingAttributes(
		[UIFontDescriptor.AttributeName.featureSettings: features]
	)

	return UIFont(descriptor: fontDescriptor, size: font.pointSize)
}

class PlusNumberView: UIView {
	let label = UILabel()

	let xMargin: CGFloat = 6
	let yMargin: CGFloat = 7

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.addSubview(label)
		self.backgroundColor = .darkGray
		self.clipsToBounds = true
	}

	func configure(with number: Int) {
		let labelAttrs: [NSAttributedStringKey: Any] = [
			NSAttributedStringKey.font: fontWithMonospacedNumbers(UIFont.preferredFont(forTextStyle: .footnote)),
			NSAttributedStringKey.foregroundColor: UIColor.white
		]
		self.label.attributedText = NSAttributedString.init(string: "+\(number)", attributes: labelAttrs)
	}

	override var intrinsicContentSize: CGSize {
		let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
		let size = label.sizeThatFits(maxSize)
		return CGSize(width: size.width + xMargin * 2, height: size.height + yMargin * 2)
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
		let size = label.sizeThatFits(maxSize)
		self.label.frame = size.centered(in: self.bounds)
		self.layer.cornerRadius = self.frame.height/2
	}

	override func sizeThatFits(_ size: CGSize) -> CGSize {
		let size = label.sizeThatFits(_: size)
		return CGSize(width: size.width + xMargin * 2, height: size.height + yMargin * 2)
	}


	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


class PresenceView: UIView {
	private var circles: [CircularAvatar] = []
	let margin: CGFloat = 8
	var plusNumberView: PlusNumberView?

	override func sizeThatFits(_ size: CGSize) -> CGSize {
		return CGSize(width: size.width, height: size.height)
	}

	override var intrinsicContentSize: CGSize {
		let circleSize = circles.first?.sizeThatFits(self.frame.size) ?? CGSize.init(width: margin, height: margin)
//		let height = max(circleSize.height, plusNumberView?.sizeThatFits(self.size))
		return CGSize.init(width: CGFloat(circles.count) * (margin + circleSize.width) + margin , height: 60)
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		let frame = self.frame
		let circleSize = circles.first?.sizeThatFits(self.frame.size) ?? CGSize.init(width: margin, height: margin)

		let numberOfAvatarsToFit = Int((frame.width - margin)/circleSize.width)
		let leftover = self.frame.width - CGFloat(numberOfAvatarsToFit) * circleSize.width

		circles.enumerated().forEach { arg in
			let (index, circle) = arg
			circle.frame = circleSize.centeredVertically(in: self.frame, left: frame.minX + margin + CGFloat(index) * (circleSize.width + margin))
			circle.alpha = (index >= numberOfAvatarsToFit - 1) ? 0.0 : 1.0
		}
	}

	func configure(with avatars: [Attendee.Avatar]) {
		self.circles.forEach { $0.removeFromSuperview() }
		let newCircles: [CircularAvatar] = avatars.flatMap { (avatar) in
			switch avatar {
			case .image(let image):
				return CircularAvatar(image: image)
			case .url:
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

		self.view.addSubview(plusNumberView)
		plusNumberView.configure(with: 12319238472983479)
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		plusNumberView.frame = CGRect(origin: CGPoint(x: 0, y: 44), size: plusNumberView.sizeThatFits(view.bounds.size))
	}
}
