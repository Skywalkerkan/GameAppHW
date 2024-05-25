//
//  CustomPageController.swift
//  MVVMGameHW
//
//  Created by Erkan on 25.05.2024.
//

import UIKit

class CustomPageControl: UIView {
    
    var numberOfPages: Int = 0 {
        didSet {
            setupDots()
        }
    }
    
    var currentPage: Int = 0 {
        didSet {
            updateDots()
        }
    }
    
    
    private var dotViews: [UIView] = []
    private let dotSize: CGFloat = 10
    private let spacing: CGFloat = 12
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDots()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDots()
    }
    
    private func setupDots() {
        dotViews.forEach { $0.removeFromSuperview() }
        dotViews.removeAll()
        
        for index in 0..<numberOfPages {
            let dotView = UIView()
            dotView.backgroundColor = UIColor.lightGray
            addSubview(dotView)
            dotView.layer.cornerRadius = 5
            dotView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                dotView.widthAnchor.constraint(equalToConstant: dotSize),
                dotView.heightAnchor.constraint(equalToConstant: dotSize),
                dotView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                dotView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CGFloat(index) * (dotSize + spacing))
            ])
            
            dotViews.append(dotView)
        }
        updateDots()
    }
    
    private func updateDots() {
        for (index, dotView) in dotViews.enumerated() {
            dotView.backgroundColor = (index == currentPage) ? Colors.blueColor : UIColor.lightGray
            dotView.layer.cornerRadius = (index == currentPage) ? 2 : 5
            let scale: CGFloat = (index == currentPage) ? 2 : 1.0
            dotView.transform = CGAffineTransform(scaleX: scale, y: 1)
        }
    }
}
