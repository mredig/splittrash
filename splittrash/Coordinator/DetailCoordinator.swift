//
//  DetailCoordinator.swift
//  splittrash
//
//  Created by Michael Redig on 5/27/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

import UIKit

class DetailCoordinator: Coordinator {
	let navigationController: UINavigationController
	var childCoordinators: [Coordinator] = []
	var detailVC: UIViewController

	init(detailNavController: UINavigationController = UINavigationController()) {
		navigationController = detailNavController
		detailVC = DetailVC()
	}

	func start() {
		navigationController.pushViewController(detailVC, animated: false)
	}
}

extension DetailCoordinator {

}
