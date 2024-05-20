//
//  FooterReusableView.swift
//  MVVMGameHW
//
//  Created by Erkan on 20.05.2024.
//

import UIKit

class FooterReusableView: UICollectionReusableView {
        
    static let identifier = "FooterReusableView"
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .black
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        activeIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func activeIndicator(){
        activityIndicator.startAnimating()
        addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 60).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 60).isActive = true

    }
    
    
}
