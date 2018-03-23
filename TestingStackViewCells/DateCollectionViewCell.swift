//
//  DateCollectionViewCell.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 22/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {

	enum State {
		case highlighted //Consider naming this differently cos highlights have a special meaning in UIKit
		case normal
	}

	let dateLabel = UILabel()
	let monthLabel = UILabel()

	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()
	}

}
