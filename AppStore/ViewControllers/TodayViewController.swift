//
//  TodayViewController.swift
//  AppStore
//
//  Created by Caner Karabulut on 18.03.2024.
//

import Foundation
import UIKit

class TodayViewController: UIViewController {
    //MARK: - Properties    
    private let todayModelResult: [Today] = modelData
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}
//MARK: - Helpers
extension TodayViewController {
    private func style() {
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TodayCollectionViewCell.self, forCellWithReuseIdentifier: TodayCollectionViewCell.cellIdentifier)
        view.addSubview(collectionView)
    }
}
//MARK: - UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
extension TodayViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todayModelResult.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayCollectionViewCell.cellIdentifier, for: indexPath) as? TodayCollectionViewCell else { return UICollectionViewCell() }
        cell.today = self.todayModelResult[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width / 1.2, height: view.frame.height / 2.25)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedToday = todayModelResult[indexPath.row]
        let detailViewController = TodayDetailViewController()
        detailViewController.todayDetailResult = [TodayDetailViewModel(today: selectedToday)]
        detailViewController.view.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: view.bounds.height)
        addChild(detailViewController)
        view.addSubview(detailViewController.view)

        UIView.animate(withDuration: 0.3) {
            detailViewController.view.frame = self.view.bounds
        }
    }
}
