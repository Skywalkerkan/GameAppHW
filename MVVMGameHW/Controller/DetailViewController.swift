//
//  DetailViewController.swift
//  MVVMGameHW
//
//  Created by Erkan on 20.05.2024.
//

import UIKit
import SDWebImage
import AVFoundation

class DetailViewController: UIViewController {
    
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    
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
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
       // scrollView.contentInsetAdjustmentBehavior = .never
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
    
    let screenImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var viewModel: DetailViewModelProtocol!{
        didSet{
            viewModel.delegate = self
        }
    }
    
    var id = 0
    var englishAllText: String = ""
    var isShowingFullText = false
    var timer: Timer?
    var currentIndexPath: IndexPath = IndexPath(item: 0, section: 0)
    var selectedIndexPath: IndexPath?
    var previousIndexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load(id: id)
        setupViews()
        let labelTapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
      //  labelTapGesture.cancelsTouchesInView = false
        descriptonLabel.addGestureRecognizer(labelTapGesture)
        setupTagCollectionView()
        setupScreenCollectionView()
      //  timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(updateIndexPath), userInfo: nil, repeats: true)

    }
    
    @objc func updateIndexPath() {
         // Önceki seçili hücreyi sıfırlama yeri burası
         if let previousIndexPath = selectedIndexPath,
            let previousCell = screenShotsCollectionView.cellForItem(at: previousIndexPath) as? ScreenCell {
             previousCell.backView.layer.borderColor = UIColor.clear.cgColor
             previousCell.backView.layer.borderWidth = 0
             previousCell.arrowImageView.isHidden = true
         }

         // Yeni indexPath'i hesaplama yeri burası
         let numberOfItems = screenShotsCollectionView.numberOfItems(inSection: 0)
         let nextItem = (currentIndexPath.item + 1) % numberOfItems
         currentIndexPath = IndexPath(item: nextItem, section: 0)

         // Yeni seçili hücreyi güncelleme yeri burası
         if let cell = screenShotsCollectionView.cellForItem(at: currentIndexPath) as? ScreenCell {
             cell.backView.layer.borderColor = UIColor.white.cgColor
             cell.backView.layer.borderWidth = 3
             cell.arrowImageView.isHidden = false
             DispatchQueue.main.async {
                 self.screenImageView.image = cell.gameImageView.image
             }
             screenShotsCollectionView.scrollToItem(at: currentIndexPath, at: .centeredHorizontally, animated: true)
             selectedIndexPath = currentIndexPath
         }
     }
    
    deinit {
            timer?.invalidate()
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
    
    private func setupViews(){
        view.backgroundColor = Colors.secondBackgroundColor
        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollStackViewContainer)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        
        scrollView.addSubview(scrollStackViewContainer)
        scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollStackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        scrollStackViewContainer.addArrangedSubview(gameImageView)
        gameImageView.heightAnchor.constraint(equalToConstant: view.frame.height*0.25).isActive = true
        
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
        
        let tagWrapper = UIView()
        tagWrapper.addSubview(tagsLabel)
        NSLayoutConstraint.activate([
            tagsLabel.leadingAnchor.constraint(equalTo: tagWrapper.leadingAnchor, constant: 8), // Sol boşluk
            tagsLabel.trailingAnchor.constraint(equalTo: tagWrapper.trailingAnchor, constant: -8),
            tagsLabel.topAnchor.constraint(equalTo: tagWrapper.topAnchor),
            tagsLabel.bottomAnchor.constraint(equalTo: tagWrapper.bottomAnchor)
        ])
        scrollStackViewContainer.addArrangedSubview(tagWrapper)
    
        scrollStackViewContainer.addArrangedSubview(tagCollectionView)
        tagCollectionView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        

       // let screenImageViewWrapper = UIView()
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
            return maxCount
        case screenShotsCollectionView:
            return viewModel.mediaItems?.count ?? 0
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
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView{
        case screenShotsCollectionView:
            return CGSize(width: 120, height: 90)
        default:
            return CGSize(width: tagCollectionView.frame.width, height: tagCollectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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
        hideLodingView()
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
           let trailer = viewModel.trailers{
            DispatchQueue.main.async {
                self.configure(gameDetail: gameDetails, screenShots: screenShots)
                self.maxCount = self.isExceedingScreenWidth() ?? 6
                self.tagCollectionView.reloadData()
                self.screenShotsCollectionView.reloadData()
            }
        }
    }
    
    
}
