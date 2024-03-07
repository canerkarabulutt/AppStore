//
//  AppDetailCell.swift
//  AppStore
//
//  Created by Caner Karabulut on 6.03.2024.
//

import UIKit

class AppDetailCell: UICollectionViewCell {
    static let cellIdentifier = "AppDetailCell"
    //MARK: - Properties
    private let appIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .red
        imageView.layer.cornerRadius = 12
        imageView.layer.borderWidth = 1
        return imageView
    }()
    private let appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "App Name"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    private let newsLabel: UILabel = {
        let label = UILabel()
        label.text = "What's New?"
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
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
    var topStackView: UIStackView!
    var labelButtonStackView: UIStackView!
    var labelStackView: UIStackView!
    var fullStackView: UIStackView!
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        appIcon.image = nil
    }
}
//MARK: - Helpers
extension AppDetailCell {
    private func style() {
        backgroundColor = .systemBackground
        labelButtonStackView = UIStackView(arrangedSubviews: [appNameLabel, UIStackView(arrangedSubviews: [getButton, UIView()])])
        labelButtonStackView.axis = .vertical
        topStackView = UIStackView(arrangedSubviews: [appIcon, labelButtonStackView])
        topStackView.axis = .horizontal
        topStackView.spacing = 10
        labelStackView = UIStackView(arrangedSubviews: [newsLabel, infoLabel])
        labelStackView.axis = .vertical
        labelStackView.spacing = 4
        fullStackView = UIStackView(arrangedSubviews: [topStackView,labelStackView])
        fullStackView.axis = .vertical
        fullStackView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    private func layout() {
        contentView.addSubview(fullStackView)
        
        NSLayoutConstraint.activate([
            appIcon.widthAnchor.constraint(equalToConstant: 140),
            appIcon.heightAnchor.constraint(equalToConstant: 140),
            
            getButton.heightAnchor.constraint(equalToConstant: 36),
            getButton.widthAnchor.constraint(equalToConstant: 90),
            
            fullStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            fullStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            fullStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            fullStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

