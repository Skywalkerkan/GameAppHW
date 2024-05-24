//
//  FavoriteViewController.swift
//  MVVMGameHW
//
//  Created by Erkan on 24.05.2024.
//

import Foundation
import UIKit


class FavoriteViewController: UIViewController{
    
    let gameCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cw = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cw.backgroundColor = Colors.backgroundColor
        cw.translatesAutoresizingMaskIntoConstraints = false
        return cw
    }()
    
    var viewModel: FavoriteViewModelProtocol! {
        didSet{
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        viewModel.load()
        setupCollectionView()
    }
    
    private func setupCollectionView(){
        gameCollectionView.delegate = self
        gameCollectionView.dataSource = self
        view.addSubview(gameCollectionView)
        gameCollectionView.register(SavedGameCell.self, forCellWithReuseIdentifier: SavedGameCell.identifier)
        gameCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        gameCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        gameCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        gameCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gameCollectionView.dequeueReusableCell(withReuseIdentifier: SavedGameCell.identifier, for: indexPath) as! SavedGameCell
        
        return cell
    }
}



extension FavoriteViewController: FavoriteViewModelDelegate{
    func reloadData() {
        DispatchQueue.main.async {
            self.gameCollectionView.reloadData()
        }
    }
    
    func showError(_ error: String) {
        print(error)
    }
    
}
