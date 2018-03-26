//
//  MonthViewController.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 22/03/18.
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

class TextCollectionViewCell: UICollectionViewCell {
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


class MyTitleView : UICollectionReusableView {
	weak var lab : UILabel!
	override init(frame: CGRect) {
		super.init(frame:frame)
		let lab = UILabel(frame:self.bounds)
		self.addSubview(lab)
		lab.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		lab.font = UIFont(name: "GillSans-Bold", size: 40)
		lab.text = "Testing"
		self.lab = lab
	}
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

class MyFlowLayout: UICollectionViewFlowLayout {
	private let titleKind = "title"
	private let titleHeight : CGFloat = 50
	private var titleRect : CGRect {
		return CGRect(x: 10, y: 0, width: 200, height: self.titleHeight)
	}

	override init() {
		super.init()
		self.minimumInteritemSpacing = 0.5
		self.minimumLineSpacing = 0.5
		self.sectionInset = .zero
		self.register(MyTitleView.self, forDecorationViewOfKind:self.titleKind)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutAttributesForDecorationView(
		ofKind elementKind: String, at indexPath: IndexPath)
		-> UICollectionViewLayoutAttributes? {
			if elementKind == self.titleKind {
				let atts = UICollectionViewLayoutAttributes(
					forDecorationViewOfKind:self.titleKind, with:indexPath)
				atts.frame = CGRect.init(x: 10, y: 10 * indexPath.row, width: 200, height: 50)
				return atts
			}
			return nil
	}

	override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		var arr = super.layoutAttributesForElements(in: rect)!
		if let decatts = self.layoutAttributesForDecorationView(
			ofKind:self.titleKind, at: IndexPath(item: 0, section: 0)) {
			if rect.contains(decatts.frame) {
				arr.append(decatts)
			}
		}


		if let decatts = self.layoutAttributesForDecorationView(
			ofKind:self.titleKind, at: IndexPath(item: 30, section: 0)) {
			if rect.contains(decatts.frame) {
				arr.append(decatts)
			}
		}
		return arr
	}

}

class MonthViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

	let dates = Array(1..<100)
	let collectionView: UICollectionView
	let layout = MyFlowLayout()

//	A week is always seven days
//
//	Currently true, but historically false. A couple of out-of-use calendars, like the Decimal calendar and the Egyptian calendar had weeks that were 7, 8, or even 10 days.
	let numberOfColumns = 7

	init() {
		self.collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		self.view.addSubview(collectionView)
		collectionView.backgroundColor = .red
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.register(TextCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        // Do any additional setup after loading the view.


    }

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		collectionView.frame = view.bounds
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
	}

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return dates.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TextCollectionViewCell else {
			return UICollectionViewCell()
		}
		cell.configure(with: indexPath.row % 30, month: "Mar")
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print("selected \(indexPath.row)")
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: Int(collectionView.frame.width/7), height: Int(collectionView.frame.width/7))
	}

}
