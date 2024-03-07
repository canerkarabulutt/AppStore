//
//  SearchViewCell.swift
//  AppStore
//
//  Created by Caner Karabulut on 7.03.2024.
//

import UIKit
import Kingfisher

class SearchViewCell: UICollectionViewCell {
    static let cellIdentifier = "SearchView"
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
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category Name"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    private let rateLabel: UILabel = {
        let label = UILabel()
        label.text = "Rate"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    private let getButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "icloud.and.arrow.down", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular))
        button.setImage(image, for: .normal)
        button.tintColor = .link
        return button
    }()
    private let appScreenImage1: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.layer.borderWidth = 1
        return imageView
    }()
    private let appScreenImage2: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.layer.borderWidth = 1
        return imageView
    }()
    private let appScreenImage3: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.layer.borderWidth = 1
        return imageView
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
        appNameLabel.sizeToFit()
        categoryLabel.sizeToFit()
        appIcon.sizeToFit()
        rateLabel.sizeToFit()
        appScreenImage1.sizeToFit()
        appScreenImage1.sizeToFit()
        appScreenImage1.sizeToFit()
        
        appIcon.frame = CGRect(x: 5, y: 10, width: (contentView.height) / 4, height: (contentView.height) / 4)
        appNameLabel.frame = CGRect(x: appIcon.right+10, y: 0, width: (contentView.width-appIcon.right-15-10-55), height: contentView.height/6)
        categoryLabel.frame = CGRect(x: appIcon.right+10, y: (appNameLabel.bottom-60)/2, width: (contentView.width-appIcon.right-15-10-55), height: contentView.height/3)
        rateLabel.frame = CGRect(x: appIcon.right+10, y: (categoryLabel.bottom-70)/2, width: (contentView.width-appIcon.right-15-10-55), height: contentView.height/3)
        getButton.frame = CGRect(x: contentView.width - 80, y: contentView.height / 10, width: 60, height: 40)
        
        appScreenImage1.frame = CGRect(x: 5, y: appIcon.bottom+10, width: (contentView.height/3) - 10, height: (contentView.height) / 1.5)
        appScreenImage2.frame = CGRect(x: appScreenImage1.right+5, y: appIcon.bottom+10, width: (contentView.height/3) - 10, height: (contentView.height) / 1.5)
        appScreenImage3.frame = CGRect(x: appScreenImage2.right+5, y: appIcon.bottom+10, width: (contentView.height/3) - 5, height: (contentView.height) / 1.5)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        appIcon.image = nil
        appNameLabel.text = nil
        categoryLabel.text = nil
        rateLabel.text = nil
        appScreenImage1.image = nil
        appScreenImage2.image = nil
        appScreenImage3.image = nil
    }
}
//MARK: - Helpers
extension SearchViewCell {
    private func style() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.clipsToBounds = true
        contentView.addSubview(appIcon)
        contentView.addSubview(appNameLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(rateLabel)
        contentView.addSubview(getButton)
        contentView.addSubview(appScreenImage1)
        contentView.addSubview(appScreenImage2)
        contentView.addSubview(appScreenImage3)
    }
    public func configure(with viewModel: SearchCellViewModel) {
        self.appNameLabel.text = viewModel.nameLabel
        self.rateLabel.text = viewModel.ratingLabel
        self.categoryLabel.text = viewModel.categoryLabel
        self.appIcon.kf.setImage(with: viewModel.appImage)
        self.appScreenImage1.kf.setImage(with: viewModel.screenPage1)
        self.appScreenImage2.kf.setImage(with: viewModel.screenPage2)
        self.appScreenImage3.kf.setImage(with: viewModel.screenPage3)
    }
}

