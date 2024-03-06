//
//  TopFreeCellView.swift
//  AppStore
//
//  Created by Caner Karabulut on 5.03.2024.
//

import UIKit
import Kingfisher

class TopFreeCellView: UICollectionViewCell {
    static let cellIdentifier = "TopFreeCellView"
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
    private let firmNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Firm Name"
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    private let freeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("FREE", for: .normal)
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
        firmNameLabel.sizeToFit()
        appIcon.sizeToFit()
        
        let imageSize: CGFloat = contentView.height - 10
        appIcon.frame = CGRect(x: 5, y: 5, width: imageSize, height: imageSize)
        
        appIcon.frame = CGRect(x: 5, y: 2, width: contentView.height-4, height: contentView.height-4)
        appNameLabel.frame = CGRect(x: appIcon.right+10, y: 10, width: contentView.width-appIcon.right-15-10-55, height: contentView.height/2)
        firmNameLabel.frame = CGRect(x: appIcon.right+10, y: contentView.height/2, width: contentView.width-appIcon.right-15-10-55, height: contentView.height/2)
        freeButton.frame = CGRect(x: contentView.width - 66, y: contentView.height - 66, width: 60, height: 30)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        appIcon.image = nil
        appNameLabel.text = nil
        firmNameLabel.text = nil
    }
}
//MARK: - Helpers
extension TopFreeCellView {
    private func style() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.clipsToBounds = true
        contentView.addSubview(appIcon)
        contentView.addSubview(appNameLabel)
        contentView.addSubview(firmNameLabel)
        contentView.addSubview(freeButton)
    }
    public func configure(with viewModel: AppsViewModel) {
        appNameLabel.text = viewModel.appName
        firmNameLabel.text = viewModel.firmName
        appIcon.kf.setImage(with: viewModel.artworkUrl)
    }
}
