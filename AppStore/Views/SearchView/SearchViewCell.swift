//
//  SearchView.swift
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
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category Name"
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    private let rateLabel: UILabel = {
        let label = UILabel()
        label.text = "Firm Name"
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    private let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.backgroundColor = UIColor(white: 0.88, alpha: 1)
        button.layer.cornerRadius = 30/2
        button.layer.borderWidth = 1
        return button
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
        
        let imageSize: CGFloat = contentView.height - 10
        appIcon.frame = CGRect(x: 5, y: 5, width: imageSize, height: imageSize)
        
        appIcon.frame = CGRect(x: 5, y: 2, width: contentView.height-4, height: contentView.height-4)
        appNameLabel.frame = CGRect(x: appIcon.right+10, y: 10, width: contentView.width-appIcon.right-15-10-55, height: contentView.height/3)
        categoryLabel.frame = CGRect(x: appIcon.right+10, y: appNameLabel.bottom-10, width: contentView.width-appIcon.right-15-10-55, height: contentView.height/3)
        rateLabel.frame = CGRect(x: appIcon.right+10, y: categoryLabel.bottom-10, width: contentView.width-appIcon.right-15-10-55, height: contentView.height/3)
        getButton.frame = CGRect(x: contentView.width - 66, y: contentView.height - 66, width: 60, height: 30)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        appIcon.image = nil
        appNameLabel.text = nil
        categoryLabel.text = nil
        rateLabel.text = nil
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
    }
}

