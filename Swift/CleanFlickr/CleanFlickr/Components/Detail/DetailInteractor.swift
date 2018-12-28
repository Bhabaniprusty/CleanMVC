//
//  DetailInteractor.swift
//  CleanFlickr
//
//  Created by Bhabani on 26/12/2018.
//  Copyright (c) 2018 Bhabani. All rights reserved.
//

import UIKit

protocol DetailBusinessLogic {
}

protocol DetailListener: class {
    
}

final class DetailInteractor: DetailBusinessLogic {
    var presenter: DetailPresentationLogic?
    var router: DetailRoutingLogic?
}
