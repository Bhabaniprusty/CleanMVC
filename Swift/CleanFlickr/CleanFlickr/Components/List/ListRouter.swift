//
//  ListRouter.swift
//  CleanFlickr
//
//  Created by Bhabani on 26/12/2018.
//  Copyright (c) 2018 Bhabani. All rights reserved.
//

import UIKit

protocol ListRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    func routeToPhotoDetailScreen(for segue: UIStoryboardSegue, viewmodel: List.Search.ViewModel.FlickrPhotoItem, withAnchor rect: CGRect)
}

final class ListRouter: NSObject, ListRoutingLogic {
    weak var viewController: ListViewController?
    private let detailBuilder: DetailBuildable

    init(viewController: ListViewController, detailBuilder: DetailBuildable) {
        self.viewController = viewController
        self.detailBuilder = detailBuilder
    }

    // MARK: Routing
    
    func routeToPhotoDetailScreen(for segue: UIStoryboardSegue, viewmodel: List.Search.ViewModel.FlickrPhotoItem, withAnchor rect: CGRect) {
        guard let detailViewController = segue.destination as? DetailViewController else { fatalError("failed to init from Storyboard") }
        if let ppc = detailViewController.popoverPresentationController {
            ppc.permittedArrowDirections = .any
            ppc.delegate = self
            ppc.sourceRect = rect
        } else if let pc = detailViewController.presentationController {
            pc.delegate = self
        }
        detailViewController.inject(viewmodel)
        detailBuilder.build(withViewController: detailViewController, listener: nil)
    }
}

extension ListRouter: UIPopoverPresentationControllerDelegate {
    
}

extension ListRouter: UIAdaptivePresentationControllerDelegate {
    func presentationController(_ controller: UIPresentationController,
                                viewControllerForAdaptivePresentationStyle
        style: UIModalPresentationStyle) -> UIViewController? {
        return UINavigationController(rootViewController: controller.presentedViewController)
    }
}
