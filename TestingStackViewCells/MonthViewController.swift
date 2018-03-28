//
//  MonthViewController.swift
//  TestingStackViewCells
//
//  Created by Robin Malhotra on 22/03/18.
//  Copyright © 2018 Robin Malhotra. All rights reserved.
//

import UIKit

class MonthViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

	let dates = Array(1..<100)
	let collectionView: UICollectionView
	let layout = MonthFlowLayout()

//	#A week is always seven days
//	Currently true, but historically false. A couple of out-of-use calendars, like the Decimal calendar and the Egyptian calendar had weeks that were 7, 8, or even 10 days.
	let numberOfColumns = 7

	init() {
		self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
		collectionView.register(DayCell.self, forCellWithReuseIdentifier: "cell")
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
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DayCell else {
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
