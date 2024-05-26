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
        cw.showsVerticalScrollIndicator = false
        cw.translatesAutoresizingMaskIntoConstraints = false
        return cw
    }()
    
    let navigationView: UIView = {
     let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "My Favorites"
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var viewModel: FavoriteViewModelProtocol! {
        didSet{
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        view.backgroundColor = Colors.backgroundColor
        setupViews()
        setupCollectionView()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.load()
    }
    
    private func setupCollectionView(){
        gameCollectionView.delegate = self
        gameCollectionView.dataSource = self
        view.addSubview(gameCollectionView)
        gameCollectionView.register(SavedGameCell.self, forCellWithReuseIdentifier: SavedGameCell.identifier)
        gameCollectionView.topAnchor.constraint(equalTo: navigationView.bottomAnchor).isActive = true
        gameCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        gameCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        gameCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func setupViews(){
        view.addSubview(navigationView)
        navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        navigationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        navigationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        navigationView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        navigationView.addSubview(titleLabel)
        titleLabel.centerYAnchor.constraint(equalTo: navigationView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: navigationView.centerXAnchor).isActive = true

    }
    
}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gameCollectionView.dequeueReusableCell(withReuseIdentifier: SavedGameCell.identifier, for: indexPath) as! SavedGameCell
        if let game =  viewModel.game(indexPath: indexPath){
            cell.configure(game: game)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = DetailViewController()
        let detailViewModel = DetailViewModel(service: GameService())
        let favoriteFavViewModel = DetailFavViewModel(service: LocalService())
        detailVC.viewModel = detailViewModel
        detailVC.favViewModel = favoriteFavViewModel
        if let id = viewModel.game(indexPath: indexPath)?.id {
            detailVC.id = Int(id)
            navigationController?.pushViewController(detailVC, animated: true)
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width - 16, height: 80)
    }
}



extension FavoriteViewController: FavoriteViewModelDelegate{
    func reloadFavData() {
        DispatchQueue.main.async {
            self.gameCollectionView.reloadData()
        }
    }
    
    func showFavError(_ error: String) {
        print(error)
    }
    
}
