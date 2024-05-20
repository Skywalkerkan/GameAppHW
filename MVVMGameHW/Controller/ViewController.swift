//
//  ViewController.swift
//  MVVMGameHW
//
//  Created by Erkan on 18.05.2024.
//

import UIKit

class ViewController: UIViewController {
    
    
    let gameCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cw = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cw.backgroundColor = .red
        cw.translatesAutoresizingMaskIntoConstraints = false
        return cw
    }()

    var viewModel: HomeViewModelProtocol!{
        didSet{
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
        setupCollectionView()
        
    }
    
    private func setupCollectionView(){
        view.addSubview(gameCollectionView)
        gameCollectionView.delegate = self
        gameCollectionView.dataSource = self
        gameCollectionView.register(GameCell.self, forCellWithReuseIdentifier: GameCell.identifier)
        gameCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        gameCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        gameCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        gameCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension ViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            if scrollView == gameCollectionView {
                let offsetY = scrollView.contentOffset.y
                let contentHeight = scrollView.contentSize.height
                let frameHeight = scrollView.frame.size.height

                if offsetY - 100 > contentHeight - frameHeight {
                    print("En son satıra ulaşıldı")
                }
            }
        }
}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(viewModel.numberOfItems)
        return viewModel.numberOfItems
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCell.identifier, for: indexPath) as! GameCell
        if let game = viewModel.game(indexPath: indexPath) {
            cell.configure(gameResult: game)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width - 16, height: view.frame.size.width - 16)
    }
    
}

extension ViewController: HomeViewModelDelegate{
    func reloadData() {
        gameCollectionView.reloadData()
    }
    
}
