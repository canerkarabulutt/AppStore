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
    case appHeaderSection(viewModel: [HeaderViewModel])
    
    var title: String {
        switch self {
            case .appHeaderSection:
                return ""
            case .topFreeSection:
                return "Top Free Apps"
            case .topPaidSection:
                return "Top Paid Apps"
        }
    }
}
class AppsViewController: UIViewController {
    //MARK: - Properties
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
//MARK: - Selectors
extension AppsViewController {
    @objc private func didTapProfile() {
        let vc = SettingsViewController()
        vc.title = "Settings"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.modalPresentationStyle = .pageSheet
        present(vc, animated: true)
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
        collectionView.register(AppHeaderCollectionViewCell.self, forCellWithReuseIdentifier: AppHeaderCollectionViewCell.cellIdentifier)
        collectionView.register(HeaderViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderViewCell.cellIdentifier)
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .done, target: self, action: #selector(didTapProfile))
    }
    private func fetchData() {
        
        var appHeaderSection: SectionType?
        var topFreeSection: SectionType?
        var topPaidSection: SectionType?
        
        let group = DispatchGroup()
        
        group.enter()
        
        APICaller.shared.getHeaderData { [weak self] result in
            defer {
                group.leave()
            }
            switch result {
                case .success(let headers):
                    var appHeaderViewModels = [HeaderViewModel]()
                    for header in headers {
                        let viewModel = HeaderViewModel(id: header.id, name: header.name, tagline: header.tagline, imageUrl: header.imageUrl)
                        appHeaderViewModels.append(viewModel)
                    }
                    let appHeaderSection = SectionType.appHeaderSection(viewModel: appHeaderViewModels)
                    DispatchQueue.main.async {
                        self?.sections.append(appHeaderSection)
                        self?.collectionView.reloadData()
                    }
                case .failure(let error):
                    print("Error: \(error)")
            }
        }
        
        group.enter()
        
        APICaller.shared.getFreeApps { [weak self] result in
            defer {
                group.leave()
            }
            switch result {
                case .success(let feed):
                    let freeAppsViewModels = feed.results.compactMap{ AppsViewModel(appName: $0.name, firmName: $0.artistName, artworkUrl: $0.artworkUrl100, id: $0.id) }
                    topFreeSection = SectionType.topFreeSection(viewModel: freeAppsViewModels)
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                case .failure(let error):
                    print("Error: \(error)")
            }
        }
        group.enter()

        APICaller.shared.getPaidApps { [weak self] result in
            defer {
                group.leave()
            }
            switch result {
                case .success(let feed):
                    let paidAppsViewModels = feed.results.compactMap({AppsViewModel(appName: $0.name, firmName: $0.artistName, artworkUrl: $0.artworkUrl100, id: $0.id)})
                    topPaidSection = SectionType.topPaidSection(viewModel: paidAppsViewModels)
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                case .failure(let error):
                    print("Error: \(error)")
            }
        }
        
        group.notify(queue: .main) {
            if let appHeaderSection = appHeaderSection {
                self.sections.append(appHeaderSection)
            }
            if let topFreeSection = topFreeSection {
                self.sections.append(topFreeSection)
            }
            if let topPaidSection = topPaidSection {
                self.sections.append(topPaidSection)
            }
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
            case .appHeaderSection(let viewModels):
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
            case .appHeaderSection(let viewModels):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppHeaderCollectionViewCell.cellIdentifier, for: indexPath) as? AppHeaderCollectionViewCell else { return UICollectionViewCell() }
                let viewModels = viewModels[indexPath.row]
                cell.configure(with: viewModels)
                return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let sectionIndex = indexPath.section
        let section = sections[sectionIndex]
        switch section {
            case .appHeaderSection:
                return
            case .topFreeSection(let viewModels):
                let viewModel = viewModels[indexPath.row]
                let detailVC = AppsDetailViewController(viewModel: viewModel)
                navigationController?.pushViewController(detailVC, animated: true)
            case .topPaidSection(let viewModels):
                let viewModel = viewModels[indexPath.row]
                let detailVC = AppsDetailViewController(viewModel: viewModel)
                navigationController?.pushViewController(detailVC, animated: true)
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
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 10, bottom: 0, trailing: 10)

                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.25)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
                section.orthogonalScrollingBehavior = .groupPaging
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
                
            case 2:
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
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 2, trailing: 10)

                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.5)), subitems: [item, item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = supplemmentaryViews
                return section
        }
    }
}
