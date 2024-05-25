//
//  gameHeader.swift
//  MVVMGameHW
//
//  Created by Erkan on 25.05.2024.
//

import UIKit

class HeaderReusableView: UICollectionReusableView {
    
    static let identifier = "HeaderReusableView"
    
    
    let bestGamesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cw = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cw.backgroundColor = Colors.backgroundColor
        cw.isPagingEnabled = true
        cw.showsHorizontalScrollIndicator = false
        cw.backgroundColor = .red
        cw.translatesAutoresizingMaskIntoConstraints = false
        return cw
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView(){
        addSubview(bestGamesCollectionView)
        bestGamesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        bestGamesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bestGamesCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        bestGamesCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
