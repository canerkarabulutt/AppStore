//
//  AppRatingCollectionViewCell.swift
//  AppStore
//
//  Created by Caner Karabulut on 12.03.2024.
//

import Foundation
import UIKit

class AppRatingCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "AppRatingCollectionViewCell"
    //MARK: - Properties
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Title Label"
        return label
    }()
    private let userLabel: UILabel = {
       let label = UILabel()
        label.text = "User Label"
        return label
    }()
    private let starLabel: UILabel = {
       let label = UILabel()
        label.text = "Star Label"
        return label
    }()
    private let textLabel: UILabel = {
       let label = UILabel()
        label.text = "Text Label"
        label.numberOfLines = 0
        return label
    }()
    private var ratingStackView: UIStackView!
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
extension AppRatingCollectionViewCell {
    private func style() {
        backgroundColor = .systemGroupedBackground
        ratingStackView = UIStackView(arrangedSubviews: [UIStackView(arrangedSubviews: [titleLabel, userLabel]),starLabel,textLabel,UIView()])
        ratingStackView.axis = .vertical
        ratingStackView.spacing = 8
        ratingStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout() {
        contentView.addSubview(ratingStackView)
        self.titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        NSLayoutConstraint.activate([
            ratingStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            ratingStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            ratingStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
            ratingStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    public func configure(with viewModel: RatingViewModel) {
        titleLabel.text = viewModel.titleText
        userLabel.text = viewModel.userText
        starLabel.text = viewModel.ratingText
        textLabel.text = viewModel.bodyText
    }
}
