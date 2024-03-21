//
//  SearchViewController.swift
//  AppStore
//
//  Created by Caner Karabulut on 5.03.2024.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    //MARK: - Properties

    private var results: [SearchResult] = []
            
    private let collectionView : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ -> NSCollectionLayoutSection in
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 10, bottom: 0, trailing: 10)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.9)), subitems: [item])
        return NSCollectionLayoutSection(group: group)
    }))
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search for products and stores"
        searchController.searchBar.searchBarStyle = .minimal
        searchController.definesPresentationContext = true
        return searchController
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        setupSearchController()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}
//MARK: - Helpers
extension SearchViewController {
    private func setupSearchController() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
    private func style() {
        view.addSubview(collectionView)
        collectionView.register(SearchViewCell.self, forCellWithReuseIdentifier: SearchViewCell.cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.backgroundColor = .systemBackground
    }
}
//MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedResult = results[indexPath.item]
        let detailViewModel = AppsViewModel(appName: selectedResult.trackName,
                                            firmName: selectedResult.primaryGenreName,
                                            artworkUrl: URL(string: selectedResult.artworkUrl100)!,
                                            id: String(selectedResult.trackId ?? 0))
        let detailVC = AppsDetailViewController(viewModel: detailViewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
//MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let query = searchController.searchBar.text, !query.isEmpty {
            fetchSearchResults(for: query)
        } else {
            results.removeAll()
            collectionView.reloadData()
        }
    }
    private func fetchSearchResults(for searchText: String) {
        APICaller.shared.search(with: searchText) { [weak self] result in
            switch result {
            case .success(let searchModel):
                self?.results = searchModel.results
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print("API Call Error: \(error)")
            }
        }
    }
}
