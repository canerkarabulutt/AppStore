//
//  AppHeaderCollectionViewCell.swift
//  AppStore
//
//  Created by Caner Karabulut on 20.03.2024.
//

import UIKit
import Kingfisher

class AppHeaderCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "AppHeaderCollectionViewCell"
    //MARK: - Properties
    private let appImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .cyan
        return imageView
    }()
    private let firmLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        return label
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "init(coder:) has not been implemented init(coder:) has not been implemented"
        return label
    }()
    private var stackView: UIStackView!
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
extension AppHeaderCollectionViewCell {
    private func style() {
        backgroundColor = .systemBackground
        stackView = UIStackView(arrangedSubviews: [firmLabel, titleLabel, appImage])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout() {
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    public func configure(with viewModel: HeaderViewModel) {
        firmLabel.text = viewModel.name
        titleLabel.text = viewModel.tagline
        appImage.kf.setImage(with: URL(string: viewModel.imageUrl))
    }
}
