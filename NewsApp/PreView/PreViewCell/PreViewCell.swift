//
//  PreViewCell.swift
//  NewsApp
//
//  Created by muslim mirzajonov on 02/06/22.
//

import Foundation
import UIKit
class PreViewCell : UITableViewCell{

    let textView: UITextView = {
        let textView = UITextView()
        textView.textColor = .black
        textView.font = .systemFont(ofSize: 12)
        textView.translatesAutoresizingMaskIntoConstraints=false
        textView.text = ""
        return textView
    }()
    
    let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints=false
        image.backgroundColor = .secondarySystemBackground
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
    
    var activityIndicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .black
        activityIndicator.translatesAutoresizingMaskIntoConstraints=false
        return activityIndicator
    }()
    
    @MainLabel(text: "", size: 16, weight: UIFont.Weight.bold, color: UIColor.black)
    var title: UILabel

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUi()
        
    }

    
    
    func setupUi(){
        contentView.addSubview(image)
        image.topOfTop(view: contentView, const: 10)
        image.leftOfLeft(view: contentView, const: 10)
        image.rightOfRight(view: contentView, const: -10)
        image.height(const: 220)
        
        image.addSubview(activityIndicator)
        activityIndicator.centerX(view: image, const: 0)
        activityIndicator.centerY(view: image, const: 0)
        
        image.addSubview(homeView)
        homeView.backgroundColor = .secondarySystemBackground.withAlphaComponent(0.5)
        homeView.leftOfLeft(view: image, const: 0)
        homeView.rightOfRight(view: image, const: -0)
        homeView.bottomOfBottom(view: image, const: -0)
        homeView.height(const: 80)
        
        homeView.addSubview(title)
        title.numberOfLines=4
        title.textAlignment = .left
        title.leftOfLeft(view: homeView, const: 10)
        title.rightOfRight(view: homeView, const: -10)
        title.topOfTop(view: homeView, const: 10)
        
        contentView.addSubview(textView)
        textView.backgroundColor = .clear
        textView.leftOfLeft(view: contentView, const: 10)
        textView.rightOfRight(view: contentView, const: -10)
        textView.topOfBottom(view: image, const: 10)
        textView.bottomOfBottom(view: contentView, const: -10)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
