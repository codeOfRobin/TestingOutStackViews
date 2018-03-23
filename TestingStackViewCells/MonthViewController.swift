//
//  MonthViewController.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 22/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import UIKit

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

		stackView.addArrangedSubview(dayLabel)
		stackView.addArrangedSubview(monthLabel)

	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()
	}

	func configure(with text: String) {
		self.backgroundColor = .white
		self.dayLabel.text = text
		self.monthLabel.text = text
	}
}

class MonthViewController: UIViewController, UICollectionViewDataSource {

	let dates = Array(1..<100)
	let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func viewDidLoad() {
        super.viewDidLoad()

		self.view.addSubview(collectionView)
		collectionView.backgroundColor = .red
		collectionView.dataSource = self
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
		return 2
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return dates.count/2
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TextCollectionViewCell else {
			return UICollectionViewCell()
		}

		let text = (0..<indexPath.row).reduce("") { (string, _) in
			return string + "text"
		}
		cell.configure(with: text)
		return cell
	}

}
