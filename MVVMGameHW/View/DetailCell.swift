//
//  DetailCell.swift
//  MVVMGameHW
//
//  Created by Erkan on 20.05.2024.
//

import UIKit
import SDWebImage

class DetailCell: UICollectionViewCell {
    
    static let identifier = "DetailCell"
    
    let gameImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = Colors.cellColor
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    let backGroundImageView: UIImageView = {
        let imageView = UIImageView()
         imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
         imageView.translatesAutoresizingMaskIntoConstraints = false
         return imageView
     }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Colors.backgroundColor
        setupViews()
    
    }
    
    private func setupViews(){
        
        addSubview(backGroundImageView)
        backGroundImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backGroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backGroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        backGroundImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        addBlurEffect(to: backGroundImageView)

        addSubview(gameImageView)
        gameImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        gameImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        gameImageView.widthAnchor.constraint(equalToConstant: 180).isActive = true
        gameImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func configure(gameDetail: GameDetail){
        if let urlString = gameDetail.backgroundImage{
            let url = URL(string: urlString)
            DispatchQueue.main.async {
                self.gameImageView.sd_setImage(with: url)
                self.backGroundImageView.sd_setImage(with: url)
            }
           
        }
    }
    
    func addBlurEffect(to imageView: UIImageView) {
           let blurEffect = UIBlurEffect(style: .light)
           let blurEffectView = UIVisualEffectView(effect: blurEffect)
           blurEffectView.translatesAutoresizingMaskIntoConstraints = false
           imageView.addSubview(blurEffectView)
           
           NSLayoutConstraint.activate([
               blurEffectView.topAnchor.constraint(equalTo: imageView.topAnchor),
               blurEffectView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
               blurEffectView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
               blurEffectView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
           ])
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
