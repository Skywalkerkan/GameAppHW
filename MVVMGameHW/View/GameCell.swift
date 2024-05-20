//
//  GameCell.swift
//  MVVMGameHW
//
//  Created by Erkan on 19.05.2024.
//

import UIKit
import SDWebImage

class GameCell: UICollectionViewCell {
    
    static let identifier = "GameCell"
    
    let gameImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    private func setupViews(){
        addSubview(gameImageView)
        gameImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        gameImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        gameImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        gameImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
    }
    
    func configure(gameResult: Result){
        if let imageURL = URL(string: gameResult.backgroundImage ?? ""){
            gameImageView.sd_setImage(with: imageURL)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
