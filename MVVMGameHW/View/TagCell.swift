//
//  TagCell.swift
//  MVVMGameHW
//
//  Created by Erkan on 22.05.2024.
//

import UIKit

class TagCell: UICollectionViewCell {
    
    static let identifier = "TagCell"
    
    let tagLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = Colors.blueColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        
        backView.addSubview(tagLabel)
        tagLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 4).isActive = true
        tagLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 12).isActive = true
        tagLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -12).isActive = true
        tagLabel.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -4).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(gameTag: String){
        tagLabel.text = gameTag
    }
}
