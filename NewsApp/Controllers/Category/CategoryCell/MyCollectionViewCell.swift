//
//  Coll.swift
//  NewsApp
//
//  Created by muslim mirzajonov on 02/06/22.
//

import Foundation
import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    static let indentifier = "MyCollectionViewCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines=0
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints=false
        return label
    }()
    
    
    let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints=false
        image.backgroundColor = .red
        image.layer.cornerRadius=6
        image.layer.masksToBounds=true
        image.clipsToBounds=true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let homeView: UIView = {
        let homeView = UIView()
        homeView.translatesAutoresizingMaskIntoConstraints=false
        homeView.backgroundColor = .white
        return homeView
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(image)
        image.leftOfLeft(view: contentView, const: 0)
        image.rightOfRight(view: contentView, const: -0)
        image.topOfTop(view: contentView, const: 0)
        image.bottomOfBottom(view: contentView, const: -0)
        
        image.addSubview(homeView)
        homeView.backgroundColor = .secondarySystemBackground.withAlphaComponent(0.5)
        homeView.leftOfLeft(view: image, const: 0)
        homeView.rightOfRight(view: image, const: -0)
        homeView.bottomOfBottom(view: image, const: -0)
        homeView.height(const: 60)
        
        homeView.addSubview(titleLabel)
        titleLabel.leftOfLeft(view: homeView, const: 10)
        titleLabel.centerY(view: homeView, const: 0)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        image.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
    }
    
}

