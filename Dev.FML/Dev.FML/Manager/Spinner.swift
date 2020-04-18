//
//  Spinner.swift
//  Dev.FML
//
//  Created by Alejandro Espinoza on 17/04/20.
//  Copyright © 2020 Alejandro Espinoza. All rights reserved.
//

import UIKit
import Foundation

open class Spinner {
    
    
    internal static var spinner: UIActivityIndicatorView?
    public static var style: UIActivityIndicatorView.Style = .whiteLarge
    public static var baseBackColor = UIColor.black.withAlphaComponent(0.8)
    public static var baseColor = UIColor.white
    //public static var imageView = UIImageView()
    
    public static func start(style: UIActivityIndicatorView.Style = style, backColor: UIColor = baseBackColor, baseColor: UIColor = baseColor) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(update), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        if spinner == nil, let window = UIApplication.shared.keyWindow {
            
            /*
            let imageName = "LogoJDF.png"
            let image = UIImage(named: imageName)
            imageView = UIImageView(image: image!)
            
            imageView.frame = CGRect(x: UIScreen.main.bounds.midX-100, y: UIScreen.main.bounds.midY-100 - 50, width: 200, height: 97)*/
            
            
            let frame = UIScreen.main.bounds
            spinner = UIActivityIndicatorView(frame: frame)
            spinner!.backgroundColor = backColor
            spinner!.style = style
            spinner?.color = baseColor
            
            
            window.addSubview(spinner!)
            //window.addSubview(imageView)
            
            
            spinner!.startAnimating()
        }
    }
    
    public static func stop() {
        if spinner != nil {
            spinner!.stopAnimating()
            spinner!.removeFromSuperview()
            spinner = nil
            //imageView.removeFromSuperview()
        }
    }
    
    @objc public static func update() {
        if spinner != nil {
            stop()
            start()
        }
    }
    
    
    
}
