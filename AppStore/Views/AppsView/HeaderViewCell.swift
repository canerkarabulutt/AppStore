//
//  HeaderViewCell.swift
//  AppStore
//
//  Created by Caner Karabulut on 5.03.2024.
//

import UIKit

class HeaderViewCell: UICollectionReusableView {
    static let cellIdentifier = "HeaderViewCell"
    //MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = ""
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 15, y: 0, width: width-30, height: height)
    }
}
//MARK: - Helpers
extension HeaderViewCell {
    private func style() {
        backgroundColor = .systemBackground
        addSubview(titleLabel)
    }
    func configure(with title: String) {
        titleLabel.text = title
    }
}
