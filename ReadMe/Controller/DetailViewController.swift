//
//  DetailViewController.swift
//  ReadMe
//
//  Created by Anderson Chagas on 15/08/20.
//  Copyright © 2020 Anderson Chagas. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    let book : Book
    
    @IBOutlet var titleLabel : UILabel!
    @IBOutlet var authorLabel : UILabel!
    @IBOutlet var imageView : UIImageView!
    @IBOutlet var reviewTextView : UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = book.title
        authorLabel.text = book.author
        imageView.image = book.image
        imageView.layer.cornerRadius = 12
        if let review = book.review {
            reviewTextView.text = review
        }
        reviewTextView.addDoneButton()
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

extension DetailViewController : UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
}

extension UITextView {
    func  addDoneButton() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.resignFirstResponder))
        toolbar.items = [flexSpace, doneButton]
        self.inputAccessoryView = toolbar
    }
}
