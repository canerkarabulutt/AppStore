//
//  AppDetailCollectionViewCell.swift
//  AppStore
//
//  Created by Caner Karabulut on 12.03.2024.
//

import UIKit
import Kingfisher

class AppDetailCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "AppDetailCollectionViewCell"
    //MARK: - Properties
    private let appIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.layer.borderWidth = 1
        return imageView
    }()
    private let appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "App Name"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    private let newsLabel: UILabel = {
        let label = UILabel()
        label.text = "What's New"
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.numberOfLines = 0
        return label
    }()
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Info"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    private lazy var getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        button.layer.cornerRadius = 36 / 2
        return button
    }()
    private let previewLabel: UILabel = {
       let label = UILabel()
        label.text = "Preview"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }()
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        infoLabel.sizeToFit()

        appIcon.frame = CGRect(x: 2, y: 4, width: (contentView.height) / 2.4, height: (contentView.height) / 2.4)
        appNameLabel.frame = CGRect(x: appIcon.right+10, y: 4, width: contentView.width - appIcon.right-10, height: 100)
        getButton.frame = CGRect(x: appIcon.right+10, y: appNameLabel.bottom+5, width: 90, height: 36)
        newsLabel.frame = CGRect(x: 8, y: appIcon.bottom+8, width: 200, height: 30)
        infoLabel.frame = CGRect(x: 4, y: newsLabel.bottom+5, width: contentView.width-2, height: contentView.height/4)
        previewLabel.frame = CGRect(x: 8, y: infoLabel.bottom+8, width: 200, height: 30)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        appIcon.image = nil
        appNameLabel.text = nil
        infoLabel.text = nil
        getButton.frame = .zero
    }
}
//MARK: - Helpers
extension AppDetailCollectionViewCell {
    private func style() {
        contentView.backgroundColor = .systemBackground
        contentView.clipsToBounds = true
        contentView.addSubview(appIcon)
        contentView.addSubview(appNameLabel)
        contentView.addSubview(getButton)
        contentView.addSubview(newsLabel)
        contentView.addSubview(infoLabel)
        contentView.addSubview(previewLabel)

    }

    public func configure(with viewModel: AppDetailViewModel) {
        appNameLabel.text = viewModel.name
        infoLabel.text = viewModel.releaseNotes
        getButton.setTitle(viewModel.formattedPrice, for: .normal)
        appIcon.kf.setImage(with: viewModel.appImageUrl)
    }
}
