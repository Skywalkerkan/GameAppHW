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
       // layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = Colors.cellColor
     //   collectionView.contentInsetAdjustmentBehavior = .
        collectionView.bounces = false
        return collectionView
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let scrollStackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let backGroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.cellColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var viewModel: DetailViewModelProtocol!{
        didSet{
            viewModel.delegate = self
        }
    }
    
    var id = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load(id: id)
        view.backgroundColor = .white
        /*view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(scrollStackViewContainer)
        scrollStackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        scrollStackViewContainer.addArrangedSubview(backGroundView)
        backGroundView.heightAnchor.constraint(equalToConstant: 1200).isActive = true*/
        

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
        detailCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

    }

}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCell.identifier, for: indexPath) as! DetailCell
        if let gameDetail = viewModel.gameDetails{
            cell.configure(gameDetail: gameDetail)
        }
        return cell
    }
    
   /* func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: 1500)
    }*/
    
}


extension DetailViewController: DetailViewModelDelegate, LoadingIndicator{
    
    func showLoadingView() {
        print("loooading")
        showLoading()
    }
    
    func hideLodingView() {
        hideLoading()
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.detailCollectionView.reloadData()
        }
    }
    
}
