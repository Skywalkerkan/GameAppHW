//
//  DetailViewController.swift
//  MVVMGameHW
//
//  Created by Erkan on 20.05.2024.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    let detailCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = Colors.secondBackgroundColor
        //collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.bounces = false
        return collectionView
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
       // scrollView.contentInsetAdjustmentBehavior = .never
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
    
    //Buradan sonrası
    let gameImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = Colors.cellColor
        imageView.contentMode = .scaleToFill
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let cellBackground: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let developerLabel: UILabel = {
        let label = UILabel()
        label.text = "Developers"
        label.textColor = Colors.darkGray
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let developerDetailLabel: UILabel = {
       let label = UILabel()
        label.textColor = Colors.blueColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let publisherLabel: UILabel = {
         let label = UILabel()
        label.text = "Publishers"
        label.textColor = Colors.darkGray
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .semibold)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    let publisherDetailLabel: UILabel = {
         let label = UILabel()
        label.textColor = Colors.blueColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .semibold)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    let releaseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "Released"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let releaseDetailLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.secondLabelColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let leftVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let rightVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let horizantalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let descriptonLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.secondLabelColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var viewModel: DetailViewModelProtocol!{
        didSet{
            viewModel.delegate = self
        }
    }
    
    var id = 0
    
    override func viewDidLayoutSubviews() {
        print(scrollView.frame.height)
        print("container \(backGroundView.frame.height)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load(id: id)
        view.backgroundColor = Colors.cellColor
        
        view.addSubview(scrollView)
        scrollView.addSubview(backGroundView)
        backGroundView.addSubview(gameImageView)
        backGroundView.addSubview(nameLabel)
        backGroundView.addSubview(horizantalStackView)
        backGroundView.addSubview(descriptonLabel)
        
        horizantalStackView.addArrangedSubview(leftVerticalStackView)
        horizantalStackView.addArrangedSubview(rightVerticalStackView)
        
        leftVerticalStackView.addArrangedSubview(developerLabel)
        leftVerticalStackView.addArrangedSubview(publisherLabel)
        leftVerticalStackView.addArrangedSubview(releaseLabel)
        
        rightVerticalStackView.addArrangedSubview(developerDetailLabel)
        rightVerticalStackView.addArrangedSubview(publisherDetailLabel)
        rightVerticalStackView.addArrangedSubview(releaseDetailLabel)

        // ScrollView Constraints
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        // BackgroundView Constraints
        backGroundView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        backGroundView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        backGroundView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        backGroundView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        backGroundView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        // GameImageView Constraints
        gameImageView.topAnchor.constraint(equalTo: backGroundView.topAnchor).isActive = true
        gameImageView.leadingAnchor.constraint(equalTo: backGroundView.leadingAnchor).isActive = true
        gameImageView.trailingAnchor.constraint(equalTo: backGroundView.trailingAnchor).isActive = true
        gameImageView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.25).isActive = true
        
        // NameLabel Constraints
        nameLabel.topAnchor.constraint(equalTo: gameImageView.bottomAnchor, constant: 8).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: backGroundView.leadingAnchor, constant: 8).isActive = true

        // HorizontalStackView Constraints
        horizantalStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        horizantalStackView.leadingAnchor.constraint(equalTo: backGroundView.leadingAnchor, constant: 8).isActive = true
        horizantalStackView.trailingAnchor.constraint(equalTo: backGroundView.trailingAnchor, constant: -8).isActive = true
        
        // LeftVerticalStackView Constraints
        leftVerticalStackView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        // DescriptionLabel Constraints
        descriptonLabel.topAnchor.constraint(equalTo: horizantalStackView.bottomAnchor, constant: 16).isActive = true
        descriptonLabel.leadingAnchor.constraint(equalTo: backGroundView.leadingAnchor, constant: 8).isActive = true
        descriptonLabel.trailingAnchor.constraint(equalTo: backGroundView.trailingAnchor, constant: -8).isActive = true
        descriptonLabel.bottomAnchor.constraint(equalTo: backGroundView.bottomAnchor, constant: -16).isActive = true
        
      //  setupCollectionView()
        
    }

    private func setupCollectionView(){
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
        detailCollectionView.register(DetailCell.self, forCellWithReuseIdentifier: DetailCell.identifier)
        view.addSubview(detailCollectionView)
        detailCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        detailCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        detailCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        detailCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func configure(gameDetail: GameDetail){
        if let urlString = gameDetail.backgroundImage{
            let url = URL(string: urlString)
            DispatchQueue.main.async {
                self.gameImageView.sd_setImage(with: url)
            }
        }
        
        nameLabel.text = gameDetail.name
        
        guard let publishers = gameDetail.publishers else { return }
        let publishersAll = publishers.map({$0.name ?? "none"})
        let publisherText = publishersAll.joined(separator: ", ")
        publisherDetailLabel.text = publisherText
        
        guard let developers = gameDetail.developers else { return }
        let developersAll = developers.map({$0.name ?? "none"})
        let developersText = developersAll.joined(separator: ", ")
        print(developersText)
        developerDetailLabel.text = developersText
        releaseDetailLabel.text = gameDetail.released
        
        let englishText = extractEnglishPart(from: gameDetail.descriptionRaw ?? " ")
        descriptonLabel.text = englishText
    }
    
    func extractEnglishPart(from text: String) -> String {
        let separator = "Español"
        if let range = text.range(of: separator) {
            return String(text[..<range.lowerBound]).trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return text
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
            cell.heightCGFloat = view.frame.height*0.3
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.detailCollectionView.bounds.size.width),
                      height: (self.detailCollectionView.bounds.size.height))
    }
    
}


extension DetailViewController: DetailViewModelDelegate, LoadingIndicator{
    
    func showLoadingView() {
        showLoading()
    }
    
    func hideLodingView() {
        hideLoading()
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.detailCollectionView.reloadData()
        }
        if let gameDetails = viewModel.gameDetails{
            DispatchQueue.main.async {
                self.configure(gameDetail: gameDetails)
            }
        }
    }
    
    
}
