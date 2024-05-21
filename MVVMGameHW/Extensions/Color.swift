//
//  Extension.swift
//  MVVMGameHW
//
//  Created by Erkan on 21.05.2024.
//

import UIKit

extension UIColor {
 
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        assert(0...255 ~= red, "Geçersiz kırmızı bileşeni")
        assert(0...255 ~= green, "Geçersiz yeşil bileşeni")
        assert(0...255 ~= blue, "Geçersiz mavi bileşeni")
        print(red, green, blue)
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            alpha: alpha
        )
    }
}

