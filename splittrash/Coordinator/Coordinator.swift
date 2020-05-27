//
//  Coordinator.swift
//  Top Albums
//
//  Created by Michael Redig on 5/6/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

import UIKit

protocol CoordinatorBase: AnyObject {
	var childCoordinators: [CoordinatorBase] { get set }

	func start()
}

protocol Coordinator: CoordinatorBase {
	var navigationController: UINavigationController { get }
}

protocol ChildCoordinator: CoordinatorBase {
	associatedtype Parent: CoordinatorParent
	var parentCoordinator: Parent? { get set }
}

protocol CoordinatorParent: CoordinatorBase {
	func childDidFinish(child: CoordinatorBase)
}
