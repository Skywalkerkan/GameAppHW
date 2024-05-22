//
//  DetailCell.swift
//  MVVMGameHW
//
//  Created by Erkan on 20.05.2024.
//

import UIKit
import SDWebImage

class DetailCell: UICollectionViewCell {
    
    static let identifier = "DetailCell"
    
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
    
    var heightCGFloat: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Colors.backgroundColor
        setupViews()
    
    }
    
    
    
    private func setupViews(){
        
        
        addSubview(gameImageView)
        print(heightCGFloat)
        gameImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        gameImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        gameImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        gameImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: gameImageView.bottomAnchor, constant: 8).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true

        addSubview(horizantalStackView)
        horizantalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        horizantalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        horizantalStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true

        horizantalStackView.addArrangedSubview(leftVerticalStackView)
        horizantalStackView.addArrangedSubview(rightVerticalStackView)

        leftVerticalStackView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        leftVerticalStackView.addArrangedSubview(developerLabel)
        leftVerticalStackView.addArrangedSubview(publisherLabel)
        leftVerticalStackView.addArrangedSubview(releaseLabel)
        
        rightVerticalStackView.addArrangedSubview(developerDetailLabel)
        rightVerticalStackView.addArrangedSubview(publisherDetailLabel)
        rightVerticalStackView.addArrangedSubview(releaseDetailLabel)
        
        addSubview(descriptonLabel)
        descriptonLabel.topAnchor.constraint(equalTo: horizantalStackView.bottomAnchor, constant: 16).isActive = true
        descriptonLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        descriptonLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true


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
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addBlurEffect(to imageView: UIImageView) {
        let blurEffect = UIBlurEffect(style: .systemChromeMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(blurEffectView)
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: imageView.topAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
    }
    
    
    func extractEnglishPart(from text: String) -> String {
        let separator = "Español"
        if let range = text.range(of: separator) {
            return String(text[..<range.lowerBound]).trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return text
    }
    
}
