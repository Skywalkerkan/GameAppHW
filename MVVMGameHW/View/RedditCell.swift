//
//  RedditCell.swift
//  MVVMGameHW
//
//  Created by Erkan on 26.05.2024.
//

import UIKit

class RedditCell: UICollectionViewCell {
    static let identifier = "RedditCell"
    
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(Colors.darkGray)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
        
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.tagColor
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bannedLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.blueColor
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "This Comment can not be seen"
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.textColor = Colors.blueColor
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let commentLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = Colors.commentColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
 
        addSubview(backView)
        backView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        backView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        backView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        backView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
        backView.addSubview(userImageView)
        userImageView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 4).isActive = true
        userImageView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 8).isActive = true
        userImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        userImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        backView.addSubview(nameLabel)
        nameLabel.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        backView.addSubview(commentLabel)
        commentLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4).isActive = true
        commentLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 8).isActive = true
        commentLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -8).isActive = true
        commentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        
        backView.addSubview(bannedLabel)
        bannedLabel.centerXAnchor.constraint(equalTo: backView.centerXAnchor).isActive = true
        bannedLabel.centerYAnchor.constraint(equalTo: backView.centerYAnchor, constant: 8).isActive = true

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(redditDetail: RedditPost?){
        
        if let redditDetail = redditDetail{
            let nameText = removeUserPrefix(from: redditDetail.username ?? "")
            nameLabel.text = nameText

            commentLabel.text = redditDetail.text?.removingHTMLTags()
            if commentLabel.text == ""{
                bannedLabel.isHidden = false
            }
            
        }
        
        if let url = URL(string: redditDetail?.image ?? ""){
            userImageView.sd_setImage(with: url)
        }
    }
    
    func removeUserPrefix(from string: String) -> String {
        if string.hasPrefix("/u/") {
            return String(string.dropFirst(3))
        }
        return string
    }

}
