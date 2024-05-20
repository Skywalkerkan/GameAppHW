//
//  DetailCell.swift
//  MVVMGameHW
//
//  Created by Erkan on 20.05.2024.
//

import UIKit

class DetailCell: UICollectionViewCell {
    
    static let identifier = "DetailCell"
    
    let gameImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .purple
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let backGroundImageView: UIImageView = {
        let imageView = UIImageView()
         imageView.backgroundColor = .white
         imageView.translatesAutoresizingMaskIntoConstraints = false
         return imageView
     }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
        
    }
    
    private func setupViews(){
        
        addSubview(backGroundImageView)
        backGroundImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backGroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backGroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        backGroundImageView.heightAnchor.constraint(equalToConstant: 1300).isActive = true

        addSubview(gameImageView)
        gameImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        gameImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        gameImageView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        gameImageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
