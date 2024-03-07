//
//  AppDetailViewController.swift
//  AppStore
//
//  Created by Caner Karabulut on 6.03.2024.
//

import UIKit

class AppDetailViewController: UIViewController {
    //MARK: - Properties
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
        layout()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}
//MARK: - Helpers
extension AppDetailViewController {
    private func style() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: AppDetailCell.cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .green
    }
    private func layout() {
        
    }
}
//MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension AppDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppDetailCell.cellIdentifier, for: indexPath) as? AppDetailCell else { return UICollectionViewCell() }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = bounds.width
        return CGSize(width: width, height: width/1.8)
    }
}
