//
//  DetailViewController.swift
//  CleanFlickr
//
//  Created by Bhabani on 26/12/2018.
//  Copyright (c) 2018 Bhabani. All rights reserved.
//

import UIKit

protocol DetailDisplayLogic: class {
}

final class DetailViewController: UIViewController, DetailDisplayLogic {
    
    var interactor: DetailBusinessLogic?
    
    @IBOutlet weak private(set) var imageView: UIImageView!
    @IBOutlet weak private(set) var titleLabel: UILabel!
    @IBOutlet private(set) var imageAspectRatioConstraint: NSLayoutConstraint!
    @IBOutlet weak  private(set) var imageContainerStackView: UIStackView!
    @IBOutlet weak private(set)var activityIndicator: UIActivityIndicatorView!

    var flickrPhoto: List.Search.ViewModel.FlickrPhotoItem!
    
    // MARK: Configuration
    private func configure() {
        activityIndicator.startAnimating()
        imageView.loadImage(withUrl: flickrPhoto.photoURL, placeholderImage: nil) { [weak self] (completed, image) in
            // stop animation
            self?.activityIndicator.stopAnimating()
            guard let image = image else { return }
            self?.updateAspectRatio(with: image)
        }
        
        titleLabel.text = flickrPhoto.model.title
//        if presentationController is UIPopoverPresentationController {
//            view.backgroundColor = .clear
//        }
    }
    
    private func updateAspectRatio(with image: UIImage) {
        imageView.removeConstraint(imageAspectRatioConstraint)
        imageAspectRatioConstraint = NSLayoutConstraint(item: imageView,
                                              attribute: .width,
                                              relatedBy: .equal,
                                              toItem: imageView,
                                              attribute: .height,
                                              multiplier: image.size.width / image.size.height,
                                              constant: 0)
        imageView.addConstraint(imageAspectRatioConstraint)
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assertDependencies()
        configure()
    }
        
    @IBAction func closeScreen(_ sender: Any) {
        dismiss(animated: true)
    }
    
    // MARK: Display logic
    
}

extension DetailViewController: Injectable {
    typealias T = List.Search.ViewModel.FlickrPhotoItem
    
    func inject(_ flickrPhoto: List.Search.ViewModel.FlickrPhotoItem) {
        self.flickrPhoto = flickrPhoto
    }
    
    func assertDependencies() {
        assert(flickrPhoto != nil)
    }
}
