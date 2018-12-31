//
//  ListViewController.swift
//  CleanFlickr
//
//  Created by Bhabani on 26/12/2018.
//  Copyright (c) 2018 Bhabani. All rights reserved.
//

import UIKit

protocol ListDisplayLogic: class {
    func displayList(viewModel: List.Search.ViewModel.FlickrPhoto)
    func display(error: Error)
}

final class ListViewController: UIViewController {
    
    var interactor: ListBusinessLogic?
    
    @IBOutlet weak private(set) var textField: UITextField!
    @IBOutlet weak private(set) var collectionView: UICollectionView!
    @IBOutlet weak private(set) var activityIndicator: UIActivityIndicatorView!
    
    fileprivate let reuseIdentifier = "FlickrCell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    fileprivate let itemsPerRow: CGFloat = 3

    private var searchGroup = SearchGroup<List.Search.ViewModel.FlickrPhotoItem>()
    // MARK: Configuration
    private func configure() {
        
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func clearAllData() {
        searchGroup.reset()
        collectionView.reloadData()
    }
    
    // MARK: Event handling
    
    func fetchPhoto(fromPage page: UInt) {
        guard let searchTerm = textField.text,!searchTerm.isEmpty else { return clearAllData() }
        let request = List.Search.Request.init(searchTerm: searchTerm, page: page)
        interactor?.fetchPhotos(request: request)
    }
    func loadPhoto() {
        clearAllData()
        fetchPhoto(fromPage: 1)
    }
    
    func loadMorePhoto() {
        fetchPhoto(fromPage: searchGroup.page + 1)  // Can have avoid the blue number
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? UICollectionViewCell else { return }
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        guard let rect = collectionView.layoutAttributesForItem(at: indexPath)?.frame else { return }
        let flickrPhoto = searchGroup.searchResults[(indexPath as NSIndexPath).row]
        interactor?.showPhotoDetailScreen(for: segue, viewmodel: flickrPhoto, withAnchor: rect)
    }
}

// MARK: Display logic

extension ListViewController: ListDisplayLogic {
    func displayList(viewModel: List.Search.ViewModel.FlickrPhoto) {
        
        activityIndicator.stopAnimating()

        let range = (searchGroup.searchResults.count..<(searchGroup.searchResults.count + (viewModel.photo?.count ?? 0)))
        searchGroup.append(results: viewModel.photo, page: viewModel.page, canLoadMore: viewModel.moreItemsAvailable)
        if viewModel.isInitalPage  {
            collectionView.reloadData()
        } else {
            collectionView.performBatchUpdates({
                let indexPaths = range.map { return IndexPath(item: $0, section: 0) }
                collectionView.insertItems(at: indexPaths)
            })
        }
    }

    func display(error: Error) {
        activityIndicator.stopAnimating()
        presentAlert(for: error)
    }
}

extension ListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        activityIndicator.startAnimating()
        loadPhoto()
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - UICollectionViewDataSource
extension ListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return searchGroup.searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                            for: indexPath) as? FlickrPhotoCell else { fatalError("failed to init from Storyboard") }
        let flickrPhoto = searchGroup.searchResults[indexPath.row]
        cell.backgroundColor = UIColor.white
        cell.startAnimating()
        cell.imageView.loadImage(withUrl: flickrPhoto.photoURLSmall, placeholderImage: nil) { [weak cell] _,_  in
            cell?.stopAnimating()
        }
        
        return cell
    }
}

// MARK: UICollectionViewDataSourcePrefetching
extension ListViewController: UICollectionViewDataSourcePrefetching {
    
    /// - Tag: Prefetching
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        // Begin asynchronously fetching data for the requested index paths.
        for indexPath in indexPaths {
            let flickrPhoto = searchGroup.searchResults[indexPath.row]
            ImageDownloader.default.fetch(with: flickrPhoto.photoURLSmall, completion: nil)
        }
    }
    
    /// - Tag: CancelPrefetching
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        // Cancel any in-flight requests for data for the specified index paths.
        for indexPath in indexPaths {
            let flickrPhoto = searchGroup.searchResults[indexPath.row]
            ImageDownloader.default.cancel(for: flickrPhoto.photoURLSmall)
        }
    }
}

extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        performSegue(withIdentifier: "showDetailScreen", sender: cell)
    }

}

extension ListViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    // another solution would be add refresh control with threshold
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if searchGroup.canLoadMore && scrollView.isScrolledToLoadMore {
            loadMorePhoto()
        }
    }

}
