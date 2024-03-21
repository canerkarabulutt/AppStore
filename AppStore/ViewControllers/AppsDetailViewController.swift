//
//  AppsDetailViewController.swift
//  AppStore
//
//  Created by Caner Karabulut on 12.03.2024.
//

import UIKit

enum DetailType {
    case details(viewModel: [AppDetailViewModel])
    case screenshots(viewModel: [AppDetailViewModel])
    case ratings(viewModel: [RatingViewModel])
}

class AppsDetailViewController: UIViewController {
    //MARK: - Properties
    
    private let viewModel: AppsViewModel
    private var detailsViewModels: [AppDetailViewModel] = []
    private var screenshotViewModels: [AppDetailViewModel] = []
    private var ratingsViewModels: [RatingViewModel] = []
    
    private var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
        return AppsDetailViewController.createSectionLayout(section: sectionIndex)
    })
    private var sections = [DetailType]()
    

    //MARK: - Lifecycle
    init(viewModel: AppsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
extension AppsDetailViewController {
    private func style() {
        view.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AppDetailCollectionViewCell.self, forCellWithReuseIdentifier: AppDetailCollectionViewCell.cellIdentifier)
        collectionView.register(AppScreenshotCollectionViewCell.self, forCellWithReuseIdentifier: AppScreenshotCollectionViewCell.cellIdentifier)
        collectionView.register(AppRatingCollectionViewCell.self, forCellWithReuseIdentifier: AppRatingCollectionViewCell.cellIdentifier)
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    }
    private func fetchData() {
        
        guard let appID = viewModel.id else {
            print("App ID is missing.")
            return
        }
        
        let group = DispatchGroup()
        
        group.enter()
            APICaller.shared.getAppDetails(with: String(appID)) { [weak self] result in
                defer {
                    group.leave()
                }
                switch result {
                    case .success(let details):
                        DispatchQueue.main.async {
                        if let detailResult = details.results.first {
                            let viewModel = AppDetailViewModel(result: detailResult)
                            self?.detailsViewModels = [viewModel]
                            let detailSection = DetailType.details(viewModel: self?.detailsViewModels ?? [])
                                self?.sections.append(detailSection)
                                self?.collectionView.reloadData()
                            }
                        }
                    case .failure(let failure):
                        print("Error fetching app details: \(failure)")
                }
            }
        
        group.enter()
        
            APICaller.shared.getScreenshots(with: String(appID)) { [weak self] result in
                defer {
                    group.leave()
                }
                switch result {
                    case .success(let screenshots):
                        DispatchQueue.main.async {
                        if let screenshotResult = screenshots.results.first {
                            let viewModel = AppDetailViewModel(result: screenshotResult)
                            self?.screenshotViewModels = viewModel.screenshotUrls?.compactMap { _ in AppDetailViewModel(result: screenshotResult) } ?? []
                            let screenshotsSection = DetailType.screenshots(viewModel: self?.screenshotViewModels ?? [])
                                self?.sections.append(screenshotsSection)
                                self?.collectionView.reloadData()
                            }
                        }
                    case .failure(let failure):
                        print("Error fetching app screenshots: \(failure)")
                }
            }
        
        group.enter()
        
            APICaller.shared.getRatingData(with: String(appID)) { [weak self] result in
                defer {
                    group.leave()
                }
                switch result {
                    case .success(let ratings):
                        DispatchQueue.main.async {
                        self?.ratingsViewModels = ratings.feed.entry.compactMap { RatingViewModel(result: $0) }
                        let ratingsSection = DetailType.ratings(viewModel: self?.ratingsViewModels ?? [])
                            self?.sections.append(ratingsSection)
                            self?.collectionView.reloadData()
                        }
                    case .failure(let failure):
                        print("Error fetching app ratings: \(failure)")
                }
            }
        group.notify(queue: .main) {
            self.collectionView.reloadData()
        }
    }
}
//MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension AppsDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = sections[section]
        switch type {
            case .details(let viewModels):
                return viewModels.count
            case .screenshots(let viewModels):
                return viewModels.count
            case .ratings(let viewModels):
                return viewModels.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = sections[indexPath.section]
        switch type {
            case .details(let viewModels):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppDetailCollectionViewCell.cellIdentifier, for: indexPath) as? AppDetailCollectionViewCell else { return UICollectionViewCell() }
                let viewModels = viewModels[indexPath.row]
                cell.configure(with: viewModels)
                return cell
            case .screenshots(let viewModels):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppScreenshotCollectionViewCell.cellIdentifier, for: indexPath) as? AppScreenshotCollectionViewCell else { return UICollectionViewCell() }
                let viewModels = viewModels[indexPath.row]
                cell.configure(with: viewModels, at: indexPath.row)
                return cell
            case .ratings(let viewModels):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppRatingCollectionViewCell.cellIdentifier, for: indexPath) as? AppRatingCollectionViewCell else { return UICollectionViewCell() }
                let viewModels = viewModels[indexPath.row]
                cell.configure(with: viewModels)
                return cell
        }
    }
}
//MARK: - Compositional Layout
extension AppsDetailViewController {
    static func createSectionLayout(section: Int) -> NSCollectionLayoutSection? {
        switch section {
            case 0:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 10, bottom: 0, trailing: 10)
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.4)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: -50, leading: 0, bottom: 0, trailing: 0)
                return section
                
            case 1:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(0.5)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: -30, leading: 0, bottom: 0, trailing: 0)
                section.orthogonalScrollingBehavior = .continuous
                return section
                
            case 2:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10)

                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.3)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
                section.orthogonalScrollingBehavior = .continuous
                return section
                
            default:
                return nil
        }
    }
}
