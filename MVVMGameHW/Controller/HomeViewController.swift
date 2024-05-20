//
//  ViewController.swift
//  MVVMGameHW
//
//  Created by Erkan on 18.05.2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    
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
    var isLoading = true
    var shouldShowFooter = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true

        viewModel.load(nextPage: nil)
        setupCollectionView()
        setupFooter()
        
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
    
    private func setupFooter(){
        gameCollectionView.register(FooterReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterReusableView.identifier)
    }
}

extension HomeViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            if scrollView == gameCollectionView {
                let offsetY = scrollView.contentOffset.y
                let contentHeight = scrollView.contentSize.height
                let frameHeight = scrollView.frame.size.height

                if offsetY - 100 > contentHeight - frameHeight {
                    if !shouldShowFooter && !isLoading {
                            shouldShowFooter = true
                            isLoading = true
                            self.gameCollectionView.performBatchUpdates({
                            self.gameCollectionView.collectionViewLayout.invalidateLayout()
                            })
                        print("Veri Çekiliyor")
                        viewModel.load(nextPage: viewModel.nextPage)
                    }
                }
            }
        }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCell.identifier, for: indexPath) as! GameCell
        if let game = viewModel.game(indexPath: indexPath) {
            cell.configure(gameResult: game)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let game = viewModel.game(indexPath: indexPath){
            print(game.name, game.id)
            let VC = DetailViewController()
            navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width - 16, height: 100)
    }
    
    //Footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if collectionView == gameCollectionView && kind == UICollectionView.elementKindSectionFooter {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterReusableView.identifier, for: indexPath) as! FooterReusableView
            return header
        } else {
            return UICollectionReusableView()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {

        if shouldShowFooter {
            return CGSize(width: collectionView.frame.width, height: 80)
        } else {
            return CGSize.zero
        }
    }

}

extension HomeViewController: HomeViewModelDelegate{
    func reloadData() {
        gameCollectionView.reloadData()
        isLoading = false
        shouldShowFooter = false
    }
    
}
