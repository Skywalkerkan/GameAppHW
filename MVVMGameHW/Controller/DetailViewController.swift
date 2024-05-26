//
//  DetailViewController.swift
//  MVVMGameHW
//
//  Created by Erkan on 20.05.2024.
//

import UIKit
import SDWebImage
import AVFoundation
import SafariServices

class DetailViewController: UIViewController {
    
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    
    let navigationView: UIView = {
     let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "arrowshape.backward.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(Colors.blueColor), for: .normal)
        button.addTarget(self, action: #selector(backClicked), for: .touchUpInside)
        return button
    }()
    
    @objc private func backClicked(){
        player?.pause()
        navigationController?.popViewController(animated: true)
    }
    
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
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let redditCollectionView: SelfSizingCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = SelfSizingCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.bounces = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let scrollStackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
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
        label.textColor = Colors.darkGray
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
    
    
    lazy var viewMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("- - - View More - - -", for: .normal)
        button.setTitleColor(Colors.blueColor, for: .normal)
        button.addTarget(self, action: #selector(viewMoreClicked), for: .touchUpInside)
        return button
    }()
    
    @objc private func viewMoreClicked(){
        player?.pause()
        if let urlString = viewModel.gameDetails?.redditURL, let url = URL(string: urlString){
            openSafariViewController(with: url)
        }
    }
    
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
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "COMMENTS"
        label.textColor = Colors.darkGray
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let screenImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var starButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        button.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func starButtonTapped() {
        
        if isStarred{
            starButton.setBackgroundImage(UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
            favViewModel.deleteItem(id: id)
        }else{
            
            starButton.setBackgroundImage(UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(Colors.blueColor), for: .normal)
            
            if let gameViewModel = viewModel.gameDetails,
               let name = gameViewModel.name,
               let id = gameViewModel.id,
               let imageData = gameImageView.image?.pngData(),
               let genres = gameViewModel.genres,
               let platforms = gameViewModel.parentPlatforms{
                
                let platformsString = platforms.reduce(into: "") { result, platform in
                    if let name = platform.platform?.name {
                        result += result.isEmpty ? name : ", \(name)"
                    }
                }

                let genresString = genres.reduce(into: "") { result, genre in
                    if let name = genre.name {
                        result += result.isEmpty ? name : ", \(name)"
                    }
                }

               let gameModel = GameLocalModel(gameId: id, imageData: imageData, platforms: platformsString, name: name, genres: genresString)
                favViewModel.saveItem(gameModel: gameModel)

            }
            
        }
        isStarred.toggle()
      }
    
    private func setupTagCollectionView(){
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        tagCollectionView.register(TagCell.self, forCellWithReuseIdentifier: TagCell.identifier)
    }
    
    private func setupScreenCollectionView(){
        screenShotsCollectionView.delegate = self
        screenShotsCollectionView.dataSource = self
        screenShotsCollectionView.register(ScreenCell.self, forCellWithReuseIdentifier: ScreenCell.identifier)
    }
    
    private func setupRedditCollectionView(){
        redditCollectionView.delegate = self
        redditCollectionView.dataSource = self
        redditCollectionView.register(RedditCell.self, forCellWithReuseIdentifier: RedditCell.identifier)
    }
    
    let infoStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let infoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tagView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let screenImageViewWrapper = UIView()
    
    var viewModel: DetailViewModelProtocol!{
        didSet{
            viewModel.delegate = self
        }
    }
    
    var favViewModel: DetailFavViewModelProtocol!{
        didSet{
            favViewModel.delegate = self
        }
    }
    
    var id = 0
    var englishAllText: String = ""
    var isShowingFullText = false
    var timer: Timer?
    var currentIndexPath: IndexPath = IndexPath(item: 0, section: 0)
    var selectedIndexPath: IndexPath?
    var previousIndexPath: IndexPath?
    var isStarred = false
    
    
    override func viewWillAppear(_ animated: Bool) {
        favViewModel.isFavorited(id: id)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load(id: id)
        setupViews()
        let labelTapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        descriptonLabel.addGestureRecognizer(labelTapGesture)
        setupTagCollectionView()
        setupScreenCollectionView()
        setupRedditCollectionView()
    }
        
    deinit {
        player?.pause()
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
    private func setupViews(){
        view.backgroundColor = Colors.secondBackgroundColor

        view.addSubview(navigationView)
        navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        navigationView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        navigationView.addSubview(backButton)
        backButton.topAnchor.constraint(equalTo: navigationView.topAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: navigationView.leadingAnchor).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true

        navigationView.addSubview(starButton)
        starButton.topAnchor.constraint(equalTo: navigationView.topAnchor).isActive = true
        starButton.trailingAnchor.constraint(equalTo: navigationView.trailingAnchor, constant: -8).isActive = true
        starButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        starButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollStackViewContainer)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: navigationView.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        
        scrollView.addSubview(scrollStackViewContainer)
        scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollStackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        scrollStackViewContainer.addArrangedSubview(gameImageView)
        gameImageView.heightAnchor.constraint(equalToConstant: view.frame.height*0.25).isActive = true
        scrollStackViewContainer.setCustomSpacing(12, after: gameImageView)

        let nameWrapper = UIView()
        nameWrapper.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: nameWrapper.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: nameWrapper.trailingAnchor, constant: -8),
            nameLabel.topAnchor.constraint(equalTo: nameWrapper.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: nameWrapper.bottomAnchor)
        ])
        scrollStackViewContainer.addArrangedSubview(nameWrapper)
        
        scrollStackViewContainer.setCustomSpacing(8, after: nameWrapper)

        scrollStackViewContainer.addArrangedSubview(infoView)
        
        infoView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        infoView.addSubview(leftVerticalStackView)
        
        leftVerticalStackView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        leftVerticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        leftVerticalStackView.addArrangedSubview(developerLabel)
        leftVerticalStackView.addArrangedSubview(publisherLabel)
        leftVerticalStackView.addArrangedSubview(releaseLabel)
        
        infoView.addSubview(rightVerticalStackView)
        rightVerticalStackView.addArrangedSubview(developerDetailLabel)
        rightVerticalStackView.addArrangedSubview(publisherDetailLabel)
        rightVerticalStackView.addArrangedSubview(releaseDetailLabel)
        rightVerticalStackView.leadingAnchor.constraint(equalTo: leftVerticalStackView.trailingAnchor, constant: 8).isActive = true

        let descriptionWrapper = UIView()
        descriptionWrapper.addSubview(descriptonLabel)
        NSLayoutConstraint.activate([
            descriptonLabel.leadingAnchor.constraint(equalTo: descriptionWrapper.leadingAnchor, constant: 8), // Sol boşluk
            descriptonLabel.trailingAnchor.constraint(equalTo: descriptionWrapper.trailingAnchor, constant: -8),
            descriptonLabel.topAnchor.constraint(equalTo: descriptionWrapper.topAnchor),
            descriptonLabel.bottomAnchor.constraint(equalTo: descriptionWrapper.bottomAnchor)
        ])

        scrollStackViewContainer.addArrangedSubview(descriptionWrapper)
        scrollStackViewContainer.setCustomSpacing(16, after: descriptionWrapper)

        let tagWrapper = UIView()
        tagWrapper.addSubview(tagsLabel)
        NSLayoutConstraint.activate([
            tagsLabel.leadingAnchor.constraint(equalTo: tagWrapper.leadingAnchor, constant: 8), // Sol boşluk
            tagsLabel.trailingAnchor.constraint(equalTo: tagWrapper.trailingAnchor, constant: -8),
            tagsLabel.topAnchor.constraint(equalTo: tagWrapper.topAnchor),
            tagsLabel.bottomAnchor.constraint(equalTo: tagWrapper.bottomAnchor)
        ])
        scrollStackViewContainer.addArrangedSubview(tagWrapper)
        scrollStackViewContainer.setCustomSpacing(2, after: tagWrapper)

        scrollStackViewContainer.addArrangedSubview(tagCollectionView)
        tagCollectionView.heightAnchor.constraint(equalToConstant: 35).isActive = true

        screenImageViewWrapper.addSubview(screenImageView)
        NSLayoutConstraint.activate([
            screenImageView.leadingAnchor.constraint(equalTo: screenImageViewWrapper.leadingAnchor, constant: 8),
            screenImageView.trailingAnchor.constraint(equalTo: screenImageViewWrapper.trailingAnchor, constant: -8),
            screenImageView.topAnchor.constraint(equalTo: screenImageViewWrapper.topAnchor),
            screenImageView.bottomAnchor.constraint(equalTo: screenImageViewWrapper.bottomAnchor),
            screenImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        scrollStackViewContainer.addArrangedSubview(screenImageViewWrapper)
        
        scrollStackViewContainer.addArrangedSubview(screenShotsCollectionView)
        scrollStackViewContainer.setCustomSpacing(-12, after: screenImageViewWrapper)
        screenShotsCollectionView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        scrollStackViewContainer.setCustomSpacing(20, after: screenShotsCollectionView)
        let commentsWrapper = UIView()
        commentsWrapper.addSubview(commentLabel)
        NSLayoutConstraint.activate([
            commentLabel.leadingAnchor.constraint(equalTo: commentsWrapper.leadingAnchor, constant: 8), // Sol boşluk
            commentLabel.trailingAnchor.constraint(equalTo: commentsWrapper.trailingAnchor, constant: -8),
            commentLabel.topAnchor.constraint(equalTo: commentsWrapper.topAnchor),
            commentLabel.bottomAnchor.constraint(equalTo: commentsWrapper.bottomAnchor)
        ])
        scrollStackViewContainer.addArrangedSubview(commentsWrapper)
        
        scrollStackViewContainer.addArrangedSubview(redditCollectionView)
        
        scrollStackViewContainer.addArrangedSubview(viewMoreButton)
        viewMoreButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    func configure(gameDetail: GameDetail, screenShots: ScreenShot){
        if let urlString = gameDetail.backgroundImage{
            let url = URL(string: urlString)
            DispatchQueue.main.async {
                self.gameImageView.sd_setImage(with: url)
            }
        }
        
        if let urlString = screenShots.results?.first?.image{
            let url = URL(string: urlString)
            DispatchQueue.main.async {
                self.screenImageView.sd_setImage(with: url)
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
    
    func openSafariViewController(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = self
        present(safariVC, animated: true, completion: nil)
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
    var maxCount = 3
    
    func setupVideoPlayer(in outerView: UIView, urlString: String?) {
        guard let urlString = urlString,
              let videoURL = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        outerView.layer.sublayers?.forEach { layer in
             if layer is AVPlayerLayer {
                 layer.removeFromSuperlayer()
             }
         }
        
        player = AVPlayer(url: videoURL)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.videoGravity = .resizeAspectFill
        playerLayer?.backgroundColor = UIColor.black.cgColor
        playerLayer?.frame = CGRect(x: 8, y: 0, width: view.frame.width-16, height: 200)
        guard let playerLayer = playerLayer else{return}
        outerView.layer.addSublayer(playerLayer)
        player?.play()
    }

}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView{
        case tagCollectionView:
            let itemCount = viewModel.gameDetails?.tags?.count ?? 0
            return min(itemCount, 3)
        case screenShotsCollectionView:
            return viewModel.mediaItems?.count ?? 0
        case redditCollectionView:
            return viewModel.redditPosts?.count ?? 0
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

            if let mediaItem = viewModel.mediaItems?[indexPath.row]{
                switch mediaItem{
                case .screenshot(let screenShot):
                    cell.configure(imageString: screenShot.image)
                    cell.videoImageView.isHidden = true
                case .trailer(let trailer):
                    cell.configure(imageString: trailer.preview)
                    cell.videoImageView.isHidden = false
                }
                if indexPath == selectedIndexPath{
                    cell.backView.layer.borderColor = UIColor.white.cgColor
                    cell.backView.layer.borderWidth = 3
                    cell.arrowImageView.isHidden = false
                }else{
                    cell.backView.layer.borderColor = UIColor.white.cgColor
                    cell.backView.layer.borderWidth = 0
                    cell.arrowImageView.isHidden = true
                }
            }
            
            return cell
            
        case redditCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RedditCell.identifier, for: indexPath) as! RedditCell
            cell.configure(redditDetail: viewModel.redditPosts?[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView{
        case screenShotsCollectionView:
            return CGSize(width: 120, height: 90)
        case tagCollectionView:
            return CGSize(width: tagCollectionView.frame.width, height: tagCollectionView.frame.height)
        case redditCollectionView:
            return CGSize(width: view.frame.width, height: 80)
        default:
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView{
        case screenShotsCollectionView:
            deselectCell(at: previousIndexPath)
            selectCell(at: indexPath)
            selectedIndexPath = indexPath
            previousIndexPath = selectedIndexPath
        if let media = viewModel.mediaItems?[indexPath.row] {
            switch media {
            case .trailer(let trailer):
                if let urlString = trailer.data?.the480 {
                    setupVideoPlayer(in: screenImageViewWrapper, urlString: urlString)
                } else {
                    player?.pause()
                    removeVideoPlayer()
                }
            default:
                player?.pause()
                removeVideoPlayer()
            }
        }
        case tagCollectionView:
            let cell = tagCollectionView.cellForItem(at: indexPath) as! TagCell
            if cell.tagLabel.text == "+"{
                print("ok")
            }
        case redditCollectionView:
            if let urlString = viewModel.redditPosts?[indexPath.row].url, let url = URL(string: urlString){
                openSafariViewController(with: url)
            }
        default:
            break
        }
    }

    func deselectCell(at indexPath: IndexPath?) {
        
        if let previousCell = screenShotsCollectionView.cellForItem(at: indexPath ?? [0, 0]) as? ScreenCell{
            previousCell.backView.layer.borderColor = UIColor.white.cgColor
            previousCell.backView.layer.borderWidth = 0
            previousCell.arrowImageView.isHidden = true
        }
    }
    
    func selectCell(at indexPath: IndexPath?) {
        
        if let chosenCell = screenShotsCollectionView.cellForItem(at: indexPath ?? [0, 0]) as? ScreenCell{
            chosenCell.backView.layer.borderColor = UIColor.white.cgColor
            chosenCell.backView.layer.borderWidth = 3
            chosenCell.arrowImageView.isHidden = false
            screenImageView.image = chosenCell.gameImageView.image
        }
    }
    
    func removeVideoPlayer() {
        screenImageViewWrapper.layer.sublayers?.forEach { layer in
            if layer is AVPlayerLayer {
                layer.removeFromSuperlayer()
            }
        }
        screenImageView.isHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
}

extension DetailViewController: DetailViewModelDelegate, LoadingIndicator{
    
    func showError(_ error: String) {
       // hideLodingView()
        let alertController = UIAlertController(title: "Alert", message: error, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Try Again", style: .cancel) { _ in
            self.viewModel.load(id: self.id)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    func showLoadingView() {
        showLoading()
    }
    
    func hideLodingView() {
        hideLoading()
    }
    
    func reloadData() {
        if let gameDetails = viewModel.gameDetails, 
            let screenShots = viewModel.screenShots,
           let trailers = viewModel.trailers,
           let redditComments = viewModel.redditPosts{
            print(redditComments.count)
            DispatchQueue.main.async {
                self.configure(gameDetail: gameDetails, screenShots: screenShots)
                self.tagCollectionView.reloadData()
                self.screenShotsCollectionView.reloadData()
                self.redditCollectionView.reloadData()
                if trailers.results?.count ?? 0 > 0{
                    self.setupVideoPlayer(in: self.screenImageViewWrapper, urlString: trailers.results?.first?.data?.the480)
                    self.selectedIndexPath = [0,0]

                }else if screenShots.results?.count ?? 0 > 0{
                    self.selectedIndexPath = [0,0]
                }
                self.redditCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(redditComments.count*86)).isActive = true
            }

        }
    }
    
}

class SelfSizingCollectionView: UICollectionView {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        isScrollEnabled = false
    }

    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }

    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}


extension DetailViewController: DetailFavViewModelDelegate{
    func isSaved() {
        print(favViewModel.isStarred)
    }
    
    func isStarredFunc() {
        print("İs Starred, \(favViewModel.isStarred)")
        isStarred = favViewModel.isStarred
        if isStarred{
            starButton.setBackgroundImage(UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(Colors.blueColor), for: .normal)
        }else{
            starButton.setBackgroundImage(UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        }
    }
    
    func showDetailFavError(error: Error) {
        hideLodingView()
        let alertController = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Try Again", style: .cancel) { _ in
            self.viewModel.load(id: self.id)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }

}

extension DetailViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
