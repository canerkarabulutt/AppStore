//
//  SettingsViewController.swift
//  AppStore
//
//  Created by Caner Karabulut on 5.03.2024.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    //MARK: - Properties
    private let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    private var sections = [Section]()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}
//MARK: - Helpers
extension SettingsViewController {
    private func configureModels() {
        sections.append(Section(title: "Account", options: [Option(title: "Apple ID")]))
        sections.append(Section(title: nil, options: [Option(title: "Payment Information")]))
        sections.append(Section(title: nil, options: [Option(title: "Add Funds to Apple ID")]))
        sections.append(Section(title: nil, options: [Option(title: "Sign Out")]))

        
        sections[1].options.append(Option(title: "Country/Region"))
        sections[2].options.append(contentsOf: [Option(title: "Gifts"), Option(title: "Ratings and Reviews")])
    }

    private func style() {
        configureModels()
        title = "Settings"
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }
}
//MARK: - UITableViewDelegate & UITableViewDataSource
extension SettingsViewController : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].options.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].options[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = sections[section]
        return model.title
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.text = sections[section].title
        
        if section == 0 {
            label.textAlignment = .center
            label.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44)
        } else {
            label.textAlignment = .left
            label.frame = CGRect(x: 16, y: 0, width: tableView.bounds.width - 16, height: 44)
        }
        headerView.addSubview(label)
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 80
        } else {
            return 20
        }
    }
}

