//
//  GameCell.swift
//  MVVMGameHW
//
//  Created by Erkan on 19.05.2024.
//

import UIKit
import SDWebImage

class GameCell: UICollectionViewCell {
    
    static let identifier = "GameCell"
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let gameImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let genresLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = Colors.thirdLabelColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let platformCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cw = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cw.backgroundColor = .clear
        cw.isUserInteractionEnabled = false
        cw.translatesAutoresizingMaskIntoConstraints = false
        return cw
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    var platformImages = [UIImage]()
    
    private func setupViews(){
        
        backgroundColor = Colors.cellColor
        addSubview(gameImageView)
        gameImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        gameImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        gameImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        gameImageView.widthAnchor.constraint(equalToConstant: 130).isActive = true
        
        addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: 8).isActive = true
        
        addSubview(genresLabel)
        genresLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        genresLabel.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: 8).isActive = true
        
        setupCollectionView()
    }
    
    func configure(gameResult: Result){
        if let imageURL = URL(string: gameResult.backgroundImage ?? ""){
            DispatchQueue.main.async {
                self.gameImageView.sd_setImage(with: imageURL, placeholderImage: nil, options: [.continueInBackground, .lowPriority])

            }
        }
        nameLabel.text = gameResult.name
        guard let genres = gameResult.genres else { return }
        let firstThreeGenres = genres.prefix(3).map({$0.name ?? "none"})
        let genresText = firstThreeGenres.joined(separator: ", ")

        genresLabel.text = genresText

        guard let platforms = gameResult.parentPlatforms else { return }

        platforms.forEach { platform in
            guard let platformName = platform.platform?.name else { return }
            switch platformName {
                case "PC":
                    if let image = UIImage(systemName: "desktopcomputer") {
                        platformImages.append(image)
                    }
                case "Xbox":
                    if let image = UIImage(systemName: "xbox.logo") {
                        platformImages.append(image)
                    }
                case "PlayStation":
                    if let image = UIImage(systemName: "playstation.logo") {
                        platformImages.append(image)
                    }
                default:
                    break
            }
        }
        print(platformImages.count)
        
    }
    
    func setupCollectionView(){
        platformCollectionView.dataSource = self
        platformCollectionView.delegate = self
        addSubview(platformCollectionView)
        platformCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        platformCollectionView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4).isActive = true
        platformCollectionView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        platformCollectionView.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: 8).isActive = true
        platformCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension GameCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        platformImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as UICollectionViewCell
        let imageView = UIImageView(image: platformImages[indexPath.row].withRenderingMode(.alwaysOriginal).withTintColor(.gray))
        imageView.contentMode = .scaleToFill
        DispatchQueue.main.async {
            cell.backgroundView = imageView
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 20, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
}
