//
//  AppsViewController.swift
//  AppStore
//
//  Created by Caner Karabulut on 5.03.2024.
//

import UIKit

enum SectionType {
    case topFreeSection(viewModel: [AppsViewModel])
    case topPaidSection(viewModel: [AppsViewModel])
    
    var title: String {
        switch self {
            case .topFreeSection:
                return "Top Free Apps"
            case .topPaidSection:
                return "Top Paid Apps"
        }
    }
}

class AppsViewController: UIViewController {
    //MARK: - Properties
    private var appArray: [Feed] = []
    
    private var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
        return AppsViewController.createSectionLayout(section: sectionIndex)
    })
    private var sections = [SectionType]()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        fetchData()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}
//MARK: - Helpers
extension AppsViewController {
    private func style() {
        view.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TopPaidCellView.self, forCellWithReuseIdentifier: TopPaidCellView.cellIdentifier)
        collectionView.register(TopFreeCellView.self, forCellWithReuseIdentifier: TopFreeCellView.cellIdentifier)
        collectionView.register(HeaderViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderViewCell.cellIdentifier)
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    }
    private func fetchData() {
        let group = DispatchGroup()
        group.enter()
        group.enter()
        
        APICaller.shared.getFreeApps { [weak self] result in
            defer {
                group.leave()
            }
            switch result {
                case .success(let feed):
                    let freeAppsViewModels = feed.results.compactMap { AppsViewModel(appName: $0.name, firmName: $0.artistName, artworkUrl: $0.artworkUrl100) }
                    let freeAppsSection = SectionType.topFreeSection(viewModel: freeAppsViewModels)
                    self?.sections.append(freeAppsSection)
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                case .failure(let error):
                    print("Error: \(error)")
            }
        }
        
        APICaller.shared.getPaidApps { [weak self] result in
            defer {
                group.leave()
            }
            switch result {
                case .success(let feed):
                    let paidAppsViewModels = feed.results.compactMap { AppsViewModel(appName: $0.name, firmName: $0.artistName, artworkUrl: $0.artworkUrl100) }
                    let paidAppsSection = SectionType.topPaidSection(viewModel: paidAppsViewModels)
                    self?.sections.append(paidAppsSection)
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                case .failure(let error):
                    print("Error: \(error)")
            }
        }
        group.notify(queue: .main) {
            self.collectionView.reloadData()
        }
    }
}
//MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension AppsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = sections[section]
        switch type {
            case .topFreeSection(let viewModels):
                return viewModels.count
            case .topPaidSection(let viewModels):
                return viewModels.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let type = sections[indexPath.section]
        switch type {
            case .topFreeSection(let viewModels):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopFreeCellView.cellIdentifier, for: indexPath) as? TopFreeCellView else { return UICollectionViewCell() }
                let viewModels = viewModels[indexPath.row]
                cell.configure(with: viewModels)
                return cell
            case .topPaidSection(let viewModels):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopPaidCellView.cellIdentifier, for: indexPath) as? TopPaidCellView else { return UICollectionViewCell() }
                let viewModels = viewModels[indexPath.row]
                cell.configure(with: viewModels)
                return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderViewCell.cellIdentifier, for: indexPath) as? HeaderViewCell, kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        let section = indexPath.section
        let title = sections[section].title
        header.configure(with: title)
        return header
    }
}
//MARK: - Compositional Layout
extension AppsViewController {
    static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        let supplemmentaryViews = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        ]
        switch section {
            case 0:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.33)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 10, bottom: 0, trailing: 10)

                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.4)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = supplemmentaryViews
                return section
                
            case 1:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 10, bottom: 0, trailing: 10)

                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.4)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = supplemmentaryViews
                
                return section
                
            default:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10)

                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.5)), subitems: [item, item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = supplemmentaryViews
                return section
        }
    }
}

