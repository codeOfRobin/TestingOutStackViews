//
//  Constants.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 11/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import UIKit


func style(from color: UIColor, weight: UIFont.Weight, size: CGFloat) -> [NSAttributedStringKey: Any] {
	return [
		.font: UIFont.systemFont(ofSize: size, weight: weight),
		.foregroundColor: color
	]
}

func style(from color: UIColor, font: UIFont) -> [NSAttributedStringKey: Any] {
	return [
		NSAttributedStringKey.font: font,
		NSAttributedStringKey.foregroundColor: color
	]
}

enum Constants {

	enum Strings {
		static let allDay = NSLocalizedString("ALL DAY", comment: "")
	}
}

enum Styles {

	enum Sizes {
		static let gutter: CGFloat = 16.0
		static let verticalInset: CGFloat = 12.0
	}

	enum Text {
		static let StartingTimeStyle = style(from: Colors.Black.defaultText.color, font: UIFont.preferredFont(forTextStyle: .subheadline))
		static let DurationStyle = style(from: Colors.Gray.medium.color, font: UIFont.preferredFont(forTextStyle: .footnote))
	}

	enum Colors {
		enum Gray {
			static let dark = "A9A9A9"
			static let medium = "A3A3A3"
		}

		enum Black {
			static let defaultText = "1D1D1D"
		}
	}
}

extension String {

	public var color: UIColor {
		return UIColor.fromHex(self)
	}

}

