//
//  TodayDetailCollectionViewCell.swift
//  AppStore
//
//  Created by Caner Karabulut on 19.03.2024.
//

import Foundation
import UIKit
import Kingfisher

class TodayDetailCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "TodayDetailCollectionViewCell"
    
    //MARK: - Properties
    private let todayDetailImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.tertiarySystemGroupedBackground.cgColor
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    private let headLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.text = "Title"
        return label
    }()
    private let subLabel: UILabel = {
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
extension TodayDetailCollectionViewCell {
    private func style() {
        contentView.backgroundColor = .systemBackground
        stackView = UIStackView(arrangedSubviews: [headLabel, subLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        todayDetailImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout() {
        contentView.addSubview(todayDetailImageView)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            todayDetailImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            todayDetailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            todayDetailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            todayDetailImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 2/5),

            stackView.topAnchor.constraint(equalTo: todayDetailImageView.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
        ])
    }
    public func configure(with viewModel: TodayDetailViewModel) {
        self.headLabel.attributedText = viewModel.title1
        self.subLabel.attributedText = viewModel.title2
        self.todayDetailImageView.image = UIImage(named: viewModel.today.imageName)
    }
}

