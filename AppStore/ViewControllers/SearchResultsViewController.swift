//
//  SearchResultsViewController.swift
//  AppStore
//
//  Created by Caner Karabulut on 7.03.2024.
//

import Foundation
import UIKit

class SearchResultsViewController: UIViewController {
    //MARK: - Properties
    private var results: [SearchResult] = []
    
    private let collectionView : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ -> NSCollectionLayoutSection in
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 10, bottom: 0, trailing: 10)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.9)), subitems: [item])
        return NSCollectionLayoutSection(group: group)
    }))

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    func update(with results: [SearchResult]) {
        self.results = results
        collectionView.reloadData()
        collectionView.isHidden = results.isEmpty
    }
}
//MARK: - Helpers
extension SearchResultsViewController {
    private func style() {
        view.addSubview(collectionView)
        collectionView.register(SearchViewCell.self, forCellWithReuseIdentifier: SearchViewCell.cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.backgroundColor = .systemBackground
    }
}
//MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return results.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        results.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchViewCell.cellIdentifier, for: indexPath) as? SearchViewCell else { return UICollectionViewCell() }
        let viewModel = SearchCellViewModel(result: results[indexPath.item])
        cell.configure(with: viewModel)
        return cell
    }
}
