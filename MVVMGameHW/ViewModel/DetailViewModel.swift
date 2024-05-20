//
//  DetailViewModel.swift
//  MVVMGameHW
//
//  Created by Erkan on 20.05.2024.
//

import Foundation

protocol DetailViewModelDelegate{
    
}

protocol DetailViewModelProtocol{
    var delegate: DetailViewModelDelegate? { get set }
    var numberOfItems: Int { get }
    func game(indexPath: IndexPath) -> Result?
}



final class DetailViewModel{
    
    
    
    
    
}
