//
//  DetailViewController.swift
//  ReadMe
//
//  Created by Anderson Chagas on 15/08/20.
//  Copyright © 2020 Anderson Chagas. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let book : Book
    
    @IBOutlet var titleLabel : UILabel!
    @IBOutlet var authorLabel : UILabel!
    @IBOutlet var imageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = book.title
        authorLabel.text = book.author
        imageView.image = book.image
        imageView.layer.cornerRadius = 12
    }
    
    required init?(coder: NSCoder) {
        fatalError("This should never be called!")
    }
    
    init?(coder: NSCoder, book: Book) {
        self.book = book
        super.init(coder: coder)
    }
    
    @IBAction func updateImage() {
      let imagePicker = UIImagePickerController()
      imagePicker.delegate = self
      imagePicker.sourceType =
        UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        ? .photoLibrary
        : .camera
      imagePicker.allowsEditing = true
      present(imagePicker, animated: true)
    }
}

extension DetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let selectedImage = info[.editedImage] as? UIImage else { return }
    imageView.image = selectedImage
    Library.saveImage(selectedImage, forBook: book)
    dismiss(animated: true)
  }
}
