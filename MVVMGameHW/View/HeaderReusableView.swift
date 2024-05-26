//
//  gameHeader.swift
//  MVVMGameHW
//
//  Created by Erkan on 25.05.2024.
//

import UIKit

class HeaderReusableView: UICollectionReusableView {
    
    static let identifier = "HeaderReusableView"

    var bestGames: [Result] = []
    
    let bestGamesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cw = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cw.isPagingEnabled = true
        cw.showsHorizontalScrollIndicator = false
        cw.clipsToBounds = true
        cw.backgroundColor = .clear
        cw.translatesAutoresizingMaskIntoConstraints = false
        return cw
    }()
    
    var pageControl: CustomPageControl = {
        let view = CustomPageControl()
        view.currentPage = 0
        view.numberOfPages = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    func configure(gameResult: [Result]){
        bestGames = Array(gameResult.prefix(3))
        
        DispatchQueue.main.async{
            self.bestGamesCollectionView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView(){
        addSubview(bestGamesCollectionView)
        bestGamesCollectionView.delegate = self
        bestGamesCollectionView.dataSource = self
        bestGamesCollectionView.register(BestGameCell.self, forCellWithReuseIdentifier: BestGameCell.identifier)
        bestGamesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        bestGamesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bestGamesCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        bestGamesCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
        
        addSubview(pageControl)
        pageControl.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -24).isActive = true
    }
}

extension HeaderReusableView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestGameCell.identifier, for: indexPath) as! BestGameCell
        cell.configure(imageUrlString: bestGames[indexPath.row].backgroundImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        bestGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let id = bestGames[indexPath.row].id{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "didSelectItemNotification"), object: id)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width-16, height: frame.height-32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == bestGamesCollectionView{
            let pageWidth = scrollView.frame.width
            let currentPage = Int(scrollView.contentOffset.x / pageWidth)
            pageControl.currentPage = currentPage
        }
    }
}
