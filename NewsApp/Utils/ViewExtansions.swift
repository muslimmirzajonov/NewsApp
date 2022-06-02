//
//  ViewExtansions.swift
//  NewsApp
//
//  Created by muslim mirzajonov on 02/06/22.
//

import Foundation
import UIKit
extension UIViewController {

    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}



extension UIView{
    //MARK: TOP and Bottom
    func topOfTop(view:UIView, const:CGFloat) {
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: const).isActive=true
    }
    func topOfBottom(view:UIView, const:CGFloat) {
        self.topAnchor.constraint(equalTo: view.bottomAnchor, constant: const).isActive=true
    }
    
    func bottomOfTop(view:UIView, const:CGFloat) {
        self.bottomAnchor.constraint(equalTo: view.topAnchor, constant: const).isActive=true
    }
    func bottomOfBottom(view:UIView, const:CGFloat) {
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: const).isActive=true
    }
    
    
    
    
    //MARK: LEFT and RIGHT
    func leftOfLeft(view:UIView, const:CGFloat) {
        self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: const).isActive=true
    }
    func leftOfRight(view:UIView, const:CGFloat) {
        self.leftAnchor.constraint(equalTo: view.rightAnchor, constant: const).isActive=true
    }
    func rightOfRight(view:UIView, const:CGFloat) {
        self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: const).isActive=true
    }
    
    func rightOfLeft(view:UIView, const:CGFloat) {
        self.rightAnchor.constraint(equalTo: view.leftAnchor, constant: const).isActive=true
    }
    
    //MARK: WIDTH and HEIGHT
    func width(const:CGFloat) {
        self.widthAnchor.constraint(equalToConstant: const).isActive=true
    }
    
    func height(const:CGFloat) {
        self.heightAnchor.constraint(equalToConstant: const).isActive=true
    }
    
    
    //MARK: CENTERS
    func centerX(view:UIView, const:CGFloat) {
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: const).isActive=true
    }
    func centerY(view:UIView, const:CGFloat) {
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: const).isActive=true
    }

//    MARK: - LEFT CENTER.X,Y RIGHT CENTER.Y,X

    func leftForCenterX(view: UIView, const:CGFloat){
        self.leftAnchor.constraint(equalTo: view.centerXAnchor,constant: const).isActive = true
    }
    func rightForCenterX(view : UIView, const: CGFloat){
        self.rightAnchor.constraint(equalTo: view.centerXAnchor,constant: const).isActive = true
    }

}


@propertyWrapper
public class MainLabel {
    public var wrappedValue: UILabel

    public init(text: String, size:Int, weight:UIFont.Weight, color:UIColor) {
        self.wrappedValue = UILabel()
        wrappedValue.text = text
        configureLabel(ofSize: size, weight: weight, color: color)
    }

    private func configureLabel(ofSize:Int, weight:UIFont.Weight, color:UIColor) {
        wrappedValue.textColor = color
        wrappedValue.font = .systemFont(ofSize: CGFloat(ofSize), weight: weight)
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
        wrappedValue.textAlignment = .center
//        wrappedValue.sizeToFit()
    }
}

class MNewsAppView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
       required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MNewsAppButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
       required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

