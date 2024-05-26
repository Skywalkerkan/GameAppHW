//
//  StringExtension.swift
//  MVVMGameHW
//
//  Created by Erkan on 26.05.2024.
//

import Foundation

extension String {
    func removingHTMLTags() -> String {
        guard let data = self.data(using: .utf8) else {
            return self
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        do {
            let attributedString = try NSAttributedString(data: data, options: options, documentAttributes: nil)
            return attributedString.string
        } catch {
            return self
        }
    }
}
