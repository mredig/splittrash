//
//  DetailCoordinator.swift
//  splittrash
//
//  Created by Michael Redig on 5/27/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

import UIKit

class DetailCoordinator: Coordinator, ChildCoordinator {
	weak var parentCoordinator: SplitCoordinator?
	let navigationController: UINavigationController
	var childCoordinators: [CoordinatorBase] = []
	var detailVC: UIViewController

	init(detailNavController: UINavigationController = UINavigationController()) {
		navigationController = detailNavController
		detailVC = DetailColorVC()
	}

	func start() {
		navigationController.pushViewController(detailVC, animated: false)
	}

	func finish() {
		parentCoordinator?.childDidFinish(child: self)
	}
}

extension DetailCoordinator {

}
