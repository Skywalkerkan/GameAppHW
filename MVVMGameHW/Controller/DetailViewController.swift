//
//  DetailViewController.swift
//  MVVMGameHW
//
//  Created by Erkan on 20.05.2024.
//

import UIKit

class DetailViewController: UIViewController {
    
    let detailCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .red
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()


    }
    

    private func setupCollectionView(){
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
        detailCollectionView.register(DetailCell.self, forCellWithReuseIdentifier: DetailCell.identifier)
        view.addSubview(detailCollectionView)
        detailCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        detailCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        detailCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        detailCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

    }


}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCell.identifier, for: indexPath) as! DetailCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: view.frame.height)
    }
    
}
