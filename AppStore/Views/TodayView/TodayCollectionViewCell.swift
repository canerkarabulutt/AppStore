//
//  TodayCollectionViewCell.swift
//  AppStore
//
//  Created by Caner Karabulut on 18.03.2024.
//

import Foundation
import UIKit
import Kingfisher

class TodayCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "TodayCollectionViewCell"
    
    var today: Today? {
        didSet { configure() }
    }
    
    //MARK: - Properties
    private let todayImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.tertiarySystemGroupedBackground.cgColor
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.text = "Title"
        return label
    }()
    private let featureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.text = "Feature Item"
        return label
    }()
    private var stackView = UIStackView()
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - Helpers
extension TodayCollectionViewCell {
    private func style() {
        contentView.backgroundColor = .systemBackground
        stackView = UIStackView(arrangedSubviews: [featureLabel, titleLabel])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        todayImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout() {
        contentView.addSubview(todayImageView)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            todayImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            todayImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            todayImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            todayImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
        ])
    }
    private func configure() {
        guard let today = self.today else { return }
        self.featureLabel.text = today.featuredTitle
        self.titleLabel.text = today.headTitle
        self.todayImageView.image = UIImage(named: today.imageName)
    }
}
