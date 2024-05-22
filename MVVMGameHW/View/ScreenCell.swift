//
//  TagCell.swift
//  MVVMGameHW
//
//  Created by Erkan on 22.05.2024.
//

import UIKit
import SDWebImage

class ScreenCell: UICollectionViewCell {
    
    static let identifier = "ScreenCell"
    
    let gameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.tagColor
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(backView)
        backView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        backView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        backView.addSubview(gameImageView)
        gameImageView.topAnchor.constraint(equalTo: backView.topAnchor).isActive = true
        gameImageView.leadingAnchor.constraint(equalTo: backView.leadingAnchor).isActive = true
        gameImageView.trailingAnchor.constraint(equalTo: backView.trailingAnchor).isActive = true
        gameImageView.bottomAnchor.constraint(equalTo: backView.bottomAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(screenShots: ScreenShotResult){
        if let url = URL(string: screenShots.image ?? ""){
            gameImageView.sd_setImage(with: url)
        }
    }
}