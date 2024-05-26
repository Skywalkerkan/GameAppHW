//
//  LoadingView.swift
//  MVVMGameHW
//
//  Created by Erkan on 21.05.2024.
//

import UIKit

class LoadingView{
    
    let activityIndicator: UIActivityIndicatorView = {
       let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.style = .large
        view.color = Colors.blueColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    static let shared = LoadingView()
    
    let blurView: UIVisualEffectView = {
       var view = UIVisualEffectView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        return view
    }()
    
    let backGroundView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    private init(){
        configure()
    }
    
    func configure(){
        blurView.frame = UIWindow(frame: UIScreen.main.bounds).frame
        activityIndicator.center = blurView.center
        blurView.contentView.addSubview(activityIndicator)

    }
    
    func startLoading(){
        UIApplication.shared.windows.first?.addSubview(blurView)
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
        blurView.removeFromSuperview()
    }
}
