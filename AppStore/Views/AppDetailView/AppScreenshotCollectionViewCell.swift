//
//  AppScreenshotCollectionViewCell.swift
//  AppStore
//
//  Created by Caner Karabulut on 12.03.2024.
//

import UIKit
import Kingfisher

class AppScreenshotCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "AppScreenshotCollectionViewCell"
    //MARK: - Properties
        
    private let screenshotImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.layer.borderWidth = 1
        return imageView
    }()
    var view = AppDetailCollectionViewCell()
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
        screenshotImage.sizeToFit()
        screenshotImage.frame = CGRect(x: 4, y: 2, width: contentView.width, height: contentView.height)
        contentView.frame.size.height = screenshotImage.frame.maxY + 10
    }
}
//MARK: - Helpers
extension AppScreenshotCollectionViewCell {
    private func style() {
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(view)
        contentView.addSubview(screenshotImage)
    }
    public func configure(with viewModel: AppDetailViewModel, at index: Int) {
        guard let screenshotURLs = viewModel.screenshotUrls else { return }
        guard index < screenshotURLs.count else { return }
        let url = screenshotURLs[index]
        screenshotImage.kf.setImage(with: url)
    }
}

