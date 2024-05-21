//
//  LoadingIndicator.swift
//  MVVMGameHW
//
//  Created by Erkan on 21.05.2024.
//

import UIKit

protocol LoadingIndicator where Self: UIViewController{
    func showLoading()
    func hideLoading()
}

extension LoadingIndicator{
    func showLoading(){
        LoadingView.shared.startLoading()
    }
    
    func hideLoading(){
        LoadingView.shared.hideLoading()
    }
}
