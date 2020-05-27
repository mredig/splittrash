//
//  TheTableViewC.swift
//  splittrash
//
//  Created by Michael Redig on 5/26/20.
//  Copyright © 2020 Red_Egg Productions. All rights reserved.
//

import UIKit

typealias NamedColor = (name: String, color: UIColor)
protocol TheTableViewCCoordinator: CoordinatorBase {
	func touchedColor(namedColor: NamedColor)
}

class TheTableViewC: UITableViewController {
	let colors: [NamedColor] = [("Red", .red), ("Blue", .blue), ("Magenta", .magenta), ("Pink", .systemPink), ("Teal", .systemTeal)]
	var coordinator: TheTableViewCCoordinator?

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Select Color"

		configureTableView()
	}

	private func configureTableView() {
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
	}

}

extension TheTableViewC {
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		colors.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell.textLabel?.text = colors[indexPath.row].name

		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let color = colors[indexPath.row]

		coordinator?.touchedColor(namedColor: color)
	}
}
