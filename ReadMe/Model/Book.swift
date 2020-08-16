//
//  Book.swift
//  ReadMe
//
//  Created by Anderson Chagas on 15/08/20.
//  Copyright © 2020 Anderson Chagas. All rights reserved.
//

import UIKit

struct Book {
    let title : String
    let author : String
     var image: UIImage {
      Library.loadImage(forBook: self)
      ?? LibrarySymbol.letterSquare(letter: title.first).image
    }
}
