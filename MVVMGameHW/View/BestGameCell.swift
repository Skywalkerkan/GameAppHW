//
//  BestGamesCell.swift
//  MVVMGameHW
//
//  Created by Erkan on 25.05.2024.
//

import UIKit
import SDWebImage

class BestGameCell: UICollectionViewCell {
    
    static let identifier = "BestGameCell"
    
    let gameImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        gameImageView.backgroundColor = Colors.secondBackgroundColor
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        
        backgroundColor = Colors.cellColor
        addSubview(gameImageView)
        gameImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        gameImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        gameImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        gameImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func configure(imageUrlString: String?){

        if let urlString = imageUrlString, let imageURL = URL(string: urlString){
            DispatchQueue.main.async {
                self.gameImageView.sd_setImage(with: imageURL, placeholderImage: nil, options: [.continueInBackground, .highPriority])
            }
        }
        
    }
        
       
    
}
