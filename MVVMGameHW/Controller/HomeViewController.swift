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
        NotificationCenter.default.addObserver(self, selector: #selector(handleDidSelectItemNotification(_:)), name: NSNotification.Name(rawValue: "didSelectItemNotification"), object: nil)
    }
    
    @objc private func handleDidSelectItemNotification(_ notification: Notification) {
        if let selectedGameId = notification.object as? Int {
            let VC = DetailViewController()
            VC.id = selectedGameId
            let detailViewModel = DetailViewModel(service: GameService())
            let favoriteViewModel = DetailFavViewModel(service: LocalService())
            VC.viewModel = detailViewModel
            VC.favViewModel = favoriteViewModel
            self.navigationController?.pushViewController(VC, animated: true)
        }
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

        view.addSubview(gameCollectionView)
        gameCollectionView.delegate = self
        gameCollectionView.dataSource = self
        gameCollectionView.register(GameCell.self, forCellWithReuseIdentifier: GameCell.identifier)
        gameCollectionView.topAnchor.constraint(equalTo: navigationView.bottomAnchor).isActive = true
        gameCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        gameCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        gameCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

    }
    
    private func setupFooter(){
        gameCollectionView.register(FooterReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterReusableView.identifier)
        gameCollectionView.register(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderReusableView.identifier)
    }
}

extension HomeViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == gameCollectionView {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let frameHeight = scrollView.frame.size.height
            
            if offsetY + 100 > contentHeight - frameHeight {
                if !shouldShowFooter && !isLoading && !isSearching {
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
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("issearching \(isSearching)")
        if isSearching{
            if let game = viewModel.allSearchGames?[indexPath.row]{
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
        }else{
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
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView{
        case gameCollectionView:
            return CGSize(width: view.frame.size.width - 16, height: 80)
        default:
            return CGSize()
        }
    }
    
    //Footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if kind == UICollectionView.elementKindSectionFooter{
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterReusableView.identifier, for: indexPath)
            return footer
        }else{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderReusableView.identifier, for: indexPath) as! HeaderReusableView
            header.configure(gameResult: viewModel.allGames ?? [])
            return header
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if isSearching {
             return .zero
         } else {
             return CGSize(width: view.frame.width-16, height: view.frame.height*0.3)
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
        8
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
        if viewModel.numberOfItems == 0{
            showLoading()
        }
    }
    
    func hideLoadingView() {
        hideLoading()
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.gameCollectionView.reloadData()
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
                }
            }
        }
    }
    
  
}

