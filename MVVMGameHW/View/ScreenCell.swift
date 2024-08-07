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
    
    let arrowImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrowtriangle.up.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
        return imageView
    }()
    
    let videoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrowtriangle.forward.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.darkGray)
        imageView.backgroundColor = .black
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubview(arrowImageView)
        arrowImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        arrowImageView.heightAnchor.constraint(equalToConstant: 18).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        arrowImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(backView)
        backView.topAnchor.constraint(equalTo: arrowImageView.bottomAnchor, constant: -2).isActive = true
        backView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        backView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        backView.addSubview(gameImageView)
        gameImageView.topAnchor.constraint(equalTo: backView.topAnchor).isActive = true
        gameImageView.leadingAnchor.constraint(equalTo: backView.leadingAnchor).isActive = true
        gameImageView.trailingAnchor.constraint(equalTo: backView.trailingAnchor).isActive = true
        gameImageView.bottomAnchor.constraint(equalTo: backView.bottomAnchor).isActive = true
        
        backView.addSubview(videoImageView)
        videoImageView.centerXAnchor.constraint(equalTo: backView.centerXAnchor).isActive = true
        videoImageView.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
        videoImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        videoImageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(imageString: String?){
        if let url = URL(string: imageString ?? ""){
            gameImageView.sd_setImage(with: url)
        }
    }
}
