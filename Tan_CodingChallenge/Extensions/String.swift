//
//  String.swift
//  Tan_CodingChallenge
//
//  Created by Anthony Angelo Tan on 12/9/20.
//

import Foundation
import UIKit

extension String {
  var html2AttributedString: String? {
    guard let data = data(using: .utf8) else { return nil }
    do  {
      return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:   String.Encoding.utf8.rawValue], documentAttributes: nil).string

    }  catch let error as NSError {
      print(error.localizedDescription)
      return  nil
    }
  }
}
