//
//  DetailViewController.swift
//  MVVMGameHW
//
//  Created by Erkan on 20.05.2024.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    let tagCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let screenShotsCollectionView: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
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
        view.isUserInteractionEnabled = true
        view.backgroundColor = Colors.secondBackgroundColor
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
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tagsLabel: UILabel = {
        let label = UILabel()
        label.text = "TAGS"
        label.textColor = Colors.darkGray
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var viewModel: DetailViewModelProtocol!{
        didSet{
            viewModel.delegate = self
        }
    }
    
    var id = 0
    var englishAllText: String = ""
    var isShowingFullText = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load(id: id)
        setupViews()
        let labelTapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
      //  labelTapGesture.cancelsTouchesInView = false
        descriptonLabel.addGestureRecognizer(labelTapGesture)
       // setupTagCollectionView()
        setupScreenCollectionView()
    }
    
    @objc private func labelTapped(){
        isShowingFullText.toggle()
        if isShowingFullText {
            descriptonLabel.text = englishAllText
        } else {
            setupDescriptionLabel(text: extractFirstTwoSentences(from: englishAllText))
        }
    }
    
    func setupDescriptionLabel(text: String) {
        let fullTextWithContinue = "\(text)...continue"
        let attributedString = NSMutableAttributedString(string: fullTextWithContinue)
        let continueRange = NSRange(location: text.count, length: 11)
        attributedString.addAttribute(.foregroundColor, value: Colors.blueColor, range: continueRange)
        descriptonLabel.attributedText = attributedString
    }

    private func setupTagCollectionView(){
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        tagCollectionView.register(TagCell.self, forCellWithReuseIdentifier: TagCell.identifier)
        backGroundView.addSubview(tagCollectionView)
        tagCollectionView.topAnchor.constraint(equalTo: tagsLabel.bottomAnchor, constant: 4).isActive = true
        tagCollectionView.leadingAnchor.constraint(equalTo: backGroundView.leadingAnchor, constant: 8).isActive = true
        tagCollectionView.trailingAnchor.constraint(equalTo: backGroundView.trailingAnchor, constant: -8).isActive = true
        tagCollectionView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupScreenCollectionView(){
        screenShotsCollectionView.delegate = self
        screenShotsCollectionView.dataSource = self
        screenShotsCollectionView.register(ScreenCell.self, forCellWithReuseIdentifier: ScreenCell.identifier)
        backGroundView.addSubview(screenShotsCollectionView)
        screenShotsCollectionView.topAnchor.constraint(equalTo: descriptonLabel.bottomAnchor, constant: 4).isActive = true
        screenShotsCollectionView.leadingAnchor.constraint(equalTo: backGroundView.leadingAnchor, constant: 8).isActive = true
        screenShotsCollectionView.trailingAnchor.constraint(equalTo: backGroundView.trailingAnchor, constant: -8).isActive = true
        screenShotsCollectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    let oylesineStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setupViews(){
        view.backgroundColor = Colors.secondBackgroundColor
        view.addSubview(scrollView)
        scrollView.addSubview(backGroundView)
        backGroundView.addSubview(gameImageView)
        backGroundView.addSubview(nameLabel)
        backGroundView.addSubview(horizantalStackView)
        backGroundView.addSubview(descriptonLabel)
        backGroundView.addSubview(tagsLabel)
        
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
       // backGroundView.heightAnchor.constraint(equalToConstant: 800).isActive = true
        
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
       // descriptonLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        //descriptonLabel.bottomAnchor.constraint(equalTo: backGroundView.bottomAnchor, constant: -16).isActive = true
        
        //Tags Constraints
        tagsLabel.topAnchor.constraint(equalTo: descriptonLabel.bottomAnchor, constant: 16).isActive = true
        tagsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true

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
        developerDetailLabel.text = developersText
        releaseDetailLabel.text = gameDetail.released
        
        englishAllText = extractEnglishPart(from: gameDetail.descriptionRaw ?? " ")
        setupDescriptionLabel(text: extractFirstTwoSentences(from: englishAllText))
    }
    
    func extractFirstTwoSentences(from text: String) -> String {
        var sentenceCount = 0
        var endIndex = text.startIndex
        
        for (index, character) in text.enumerated() {
            if character == "." {
                sentenceCount += 1
                if sentenceCount == 2 {
                    endIndex = text.index(text.startIndex, offsetBy: index)
                    break
                }
            }
        }
        
        return String(text[..<endIndex])
    }
    
    func extractEnglishPart(from text: String) -> String {
        let separator = "Español"
        if let range = text.range(of: separator) {
            return String(text[..<range.lowerBound]).trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return text
    }
    var totalWidth: CGFloat = 0
    func isExceedingScreenWidth() -> Int? {
        let screenWidth = UIScreen.main.bounds.width
        guard let tags = viewModel.gameDetails?.tags else{return nil}
        for i in 0...tags.count-1 {
            guard let text = viewModel.gameDetails?.tags?[i].name else{return 5}
              let width = (text.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold)]).width) + 20  // Padding değeri 12 sol 12 sağ 6 arası
              totalWidth += width
              if totalWidth > screenWidth{
                  if i == 2{
                      continue
                  }else{
                      return i
                  }
              }
          }
            return 5
        }
    
    var maxCount = 0

}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView{
        case tagCollectionView:
            return maxCount
        case screenShotsCollectionView:
            return viewModel.screenShots?.results?.count ?? 0
        default:
            return 0
        }
    }
     
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView{
        case tagCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.identifier, for: indexPath) as! TagCell
                
            if indexPath.row == maxCount-1{
                cell.configure(gameTag: "+")
            }else{
                if let tag = viewModel.gameDetails?.tags?[indexPath.row].name{
                    cell.configure(gameTag: tag)
                }
            }
            return cell
        case screenShotsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenCell.identifier, for: indexPath) as! ScreenCell
            if let screen = viewModel.screenShots?.results?[indexPath.row]{
                cell.configure(screenShots: screen)
            }
            
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView{
        case screenShotsCollectionView:
            return CGSize(width: 100, height: view.frame.height*0.15)
        default:
            return CGSize(width: tagCollectionView.frame.width, height: tagCollectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
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
    
        if let gameDetails = viewModel.gameDetails{
            DispatchQueue.main.async {
                self.configure(gameDetail: gameDetails)
                self.maxCount = self.isExceedingScreenWidth() ?? 6

                self.tagCollectionView.reloadData()
                self.screenShotsCollectionView.reloadData()
            }
        }
        
        
        
        print("Girdi")
        print(viewModel.screenShots?.count)
    }
    
    
}
