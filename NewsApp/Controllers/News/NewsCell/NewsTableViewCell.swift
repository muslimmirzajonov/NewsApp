//
//  Cell.swift
//  NewsApp
//
//  Created by muslim mirzajonov on 01/06/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell{
    static let identifier = "NewsTableViewCell"
    
    let newTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines=0
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints=false
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines=0
        label.font = .systemFont(ofSize: 17, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints=false
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(newTitleLabel)
        newTitleLabel.leftOfLeft(view: contentView, const: 10)
        newTitleLabel.rightOfRight(view: contentView, const: -10)
        newTitleLabel.topOfTop(view: contentView, const: 10)
        
        contentView.addSubview(subTitleLabel)
        subTitleLabel.leftOfLeft(view: contentView, const: 10)
        subTitleLabel.rightOfRight(view: contentView, const: -10)
        subTitleLabel.topOfBottom(view: newTitleLabel, const: 10)
        subTitleLabel.bottomOfBottom(view: contentView, const: -10)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
