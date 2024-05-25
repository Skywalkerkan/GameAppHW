//
//  ViewController.swift
//  MVVMGameHW
//
//  Created by Erkan on 18.05.2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    let navigationView: UIView = {
     let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchTextField.backgroundColor = UIColor(red: 45/255, green: 48/255, blue: 55/255, alpha: 1)
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "Megadrop"
        searchBar.searchTextField.textColor = .white
        if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField {
              let attributes: [NSAttributedString.Key: Any] = [
                  .foregroundColor: UIColor.lightGray,
                  .font: UIFont.systemFont(ofSize: 17)
              ]
              searchTextField.attributedPlaceholder = NSAttributedString(string: "Megadrop", attributes: attributes)
          }
        searchBar.searchTextField.leftView?.tintColor = .gray
        searchBar.layer.zPosition = 2
        return searchBar
    }()
    
    let noDataFoundLabel: UILabel = {
       let label = UILabel()
        label.text = "Hiç Veri yok"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let bestGamesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cw = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cw.backgroundColor = Colors.backgroundColor
        cw.isPagingEnabled = true
        cw.showsHorizontalScrollIndicator = false
        cw.translatesAutoresizingMaskIntoConstraints = false
        return cw
    }()
    
    let gameCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cw = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cw.backgroundColor = Colors.backgroundColor
        cw.translatesAutoresizingMaskIntoConstraints = false
        return cw
    }()

    var viewModel: HomeViewModelProtocol!{
        didSet{
            viewModel.delegate = self
        }
    }
    
    var pageControl: CustomPageControl = {
        let view = CustomPageControl()
        view.currentPage = 0
        view.numberOfPages = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var isLoading = true
    var shouldShowFooter = false
    var isSearching = false
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        view.backgroundColor = Colors.backgroundColor
        viewModel.load(nextPage: nil)
        setupFooter()
    }
    override func viewDidLayoutSubviews() {
        setupCollectionView()

    }



    private func setupCollectionView(){
        
        view.addSubview(navigationView)
        navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        navigationView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        navigationView.addSubview(searchBar)
        searchBar.delegate = self
        searchBar.topAnchor.constraint(equalTo: navigationView.topAnchor, constant: -4).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
        view.addSubview(bestGamesCollectionView)
        bestGamesCollectionView.delegate = self
        bestGamesCollectionView.dataSource = self
        bestGamesCollectionView.register(BestGameCell.self, forCellWithReuseIdentifier: BestGameCell.identifier)
        bestGamesCollectionView.topAnchor.constraint(equalTo: navigationView.bottomAnchor).isActive = true
        bestGamesCollectionView.heightAnchor.constraint(equalToConstant: view.frame.height*0.3).isActive = true
        bestGamesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bestGamesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        view.addSubview(pageControl)
        pageControl.topAnchor.constraint(equalTo: bestGamesCollectionView.bottomAnchor, constant: 0).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -24).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(gameCollectionView)
        gameCollectionView.delegate = self
        gameCollectionView.dataSource = self
        gameCollectionView.register(GameCell.self, forCellWithReuseIdentifier: GameCell.identifier)
        gameCollectionView.topAnchor.constraint(equalTo: pageControl.bottomAnchor).isActive = true
        gameCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
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
            
            if offsetY + 100 > contentHeight - frameHeight {
                if !shouldShowFooter && !isLoading {
                    shouldShowFooter = true
                    isLoading = true
                    self.gameCollectionView.performBatchUpdates({
                        self.gameCollectionView.collectionViewLayout.invalidateLayout()
                    })
                    viewModel.load(nextPage: viewModel.nextPage)
                }
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == bestGamesCollectionView{
            let pageWidth = scrollView.frame.width
            let currentPage = Int(scrollView.contentOffset.x / pageWidth)
            pageControl.currentPage = currentPage
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         switch collectionView {
         case gameCollectionView:
             if isSearching{
                 return viewModel.allSearchGames?.count ?? 0
             }else{
                 return viewModel.numberOfItems
             }
         case bestGamesCollectionView:
             return viewModel.numberOfItems == 0 ? 0 : 3
         default:
             return 0
         }
     } 
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView{
        case gameCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCell.identifier, for: indexPath) as! GameCell
            if isSearching{
                if let game = viewModel.allSearchGames?[indexPath.row] {
                    cell.configure(gameResult: game)
                }
            }else{
                if let game = viewModel.game(indexPath: indexPath) {
                    cell.configure(gameResult: game)
                }
            }
 
            return cell
        case bestGamesCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestGameCell.identifier, for: indexPath) as! BestGameCell
            if let urlString = viewModel.game(indexPath: indexPath)?.backgroundImage {
                cell.configure(imageUrlString: urlString)
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let game = viewModel.game(indexPath: indexPath){
            let VC = DetailViewController()
            
            if let id = game.id{
                VC.id = id
                let detailViewModel = DetailViewModel(service: GameService())
                let favoriteViewModel = DetailFavViewModel(service: LocalService())
                VC.viewModel = detailViewModel
                VC.favViewModel = favoriteViewModel
            }
            navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView{
        case gameCollectionView:
            return CGSize(width: view.frame.size.width - 16, height: 80)
        case bestGamesCollectionView:
            return CGSize(width: view.frame.width-16, height: view.frame.height*0.3)
        default:
            return CGSize()
        }
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
}

extension HomeViewController: HomeViewModelDelegate, LoadingIndicator{
    func showLoadingView() {
        if viewModel.numberOfItems == 0 || viewModel.allSearchGames?.count == 0{
            //İlk başladığında Yap
            showLoading()
        }
    }
    
    func hideLoadingView() {
        hideLoading()
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.gameCollectionView.reloadData()
            self.bestGamesCollectionView.reloadData()
        }

        isLoading = false
        shouldShowFooter = false
    }
    
}

extension HomeViewController: UISearchBarDelegate {
  
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let trimmedText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        let components = trimmedText.components(separatedBy: .whitespaces)
        for component in components {
            if component.count > 3 {
                isSearching = true
                print("Geçerli metin: \(trimmedText)")
                viewModel.search(searchText: trimmedText)

                if viewModel.allSearchGames?.count == 0{
                    
                }
            }else if searchText == ""{
                print("Buraya giriyor")
                viewModel.load(nextPage: nil)
                isSearching = false
                DispatchQueue.main.async {
                    self.gameCollectionView.reloadData()
                    self.bestGamesCollectionView.reloadData()
                }
            }
        }
    }
    
  
}

