//
//  TodayDetailViewController.swift
//  AppStore
//
//  Created by Caner Karabulut on 19.03.2024.
//

import Foundation
import UIKit

class TodayDetailViewController: UIViewController {
    //MARK: - Properties
    var todayDetailResult : [TodayDetailViewModel] = []
        
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        addDismissGesture()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}
//MARK: - Selector
extension TodayDetailViewController {
    private func addDismissGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissTodayDetailViewController))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissTodayDetailViewController() {
        UIView.animate(withDuration: 0.3) {
            self.view.frame = CGRect(x: 0, y: self.view.bounds.height, width: self.view.bounds.width, height: self.view.bounds.height)
        } completion: { _ in
            self.removeFromParent()
            self.view.removeFromSuperview()
        }
    }
}
//MARK: - Helpers
extension TodayDetailViewController {
    private func style() {
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TodayDetailCollectionViewCell.self, forCellWithReuseIdentifier: TodayDetailCollectionViewCell.cellIdentifier)
        view.addSubview(collectionView)
    }
}
//MARK: - UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
extension TodayDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todayDetailResult.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayDetailCollectionViewCell.cellIdentifier, for: indexPath) as? TodayDetailCollectionViewCell else { return UICollectionViewCell() }
        let viewModel = todayDetailResult[indexPath.row]
        cell.configure(with: viewModel)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.height)
    }
}

