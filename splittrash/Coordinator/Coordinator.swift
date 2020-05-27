//
//  Coordinator.swift
//  Top Albums
//
//  Created by Michael Redig on 5/6/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

import UIKit

protocol CoordinatorBase {
	var childCoordinators: [Coordinator] { get set }

	func start()
}

protocol Coordinator: CoordinatorBase {
	var navigationController: UINavigationController { get }
}
