//
//  MeteoViewController.swift
//  Meteo
//
//  Created by Leo Marcotte on 24/10/2017.
//  Copyright © 2017 Leo Marcotte. All rights reserved.
//

import UIKit
import Material
import RealmSwift

class MeteoViewController: UIViewController {

    fileprivate var tableView: TableView!
    
    fileprivate var addCityBarButton: IconButton!
    fileprivate var citiesResult: Results<City>?
    fileprivate var notificationToken: NotificationToken? = nil
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareNavigationBar()
        prepareTableView()
        
        
        
        let realm = try! Realm()
        citiesResult = realm.objects(City.self)
        
        notificationToken = citiesResult?.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.endUpdates()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }

    @objc internal func addCityBarButtonPressed(sender: Button) {
        
        
        let alert = UIAlertController(title: "Add a city", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Add", style: UIAlertActionStyle.default, handler: { (action) in
            let textField = alert.textFields![0]
            getWeather(for: textField.text ?? "") { (error) in
                if let e = error {
                    self.snackbarController?.snackbar.text = e.localizedDescription
                    self.snackbarController?.animate(snackbar: .visible, delay: 1)
                    self.snackbarController?.animate(snackbar: .hidden, delay: 4)
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "cancel", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        alert.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Enter zip code or city name"
        })
        self.present(alert, animated: true, completion: nil)
    }

}



// MARK: - NavigationBar
extension MeteoViewController {
    
    fileprivate func prepareNavigationBar() {
        prepareAddCityBarButton()

        navigationController?.navigationBar.backgroundColor = Color.amber.base
        navigationItem.rightViews = [addCityBarButton]
    }

    fileprivate func prepareAddCityBarButton() {
        addCityBarButton = IconButton(image: Icon.add, tintColor: .white)
        addCityBarButton.addTarget(self, action: #selector(addCityBarButtonPressed(sender:)), for: .touchUpInside)
    }
    
}


// MARK: - View
extension MeteoViewController {
    
    
    fileprivate func prepareTableView() {
        tableView = TableView()
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
}

// MARK: - UITableViewDataSource
extension MeteoViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(citiesResult?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CityTableViewCell else {
            return UITableViewCell()
        }
        guard let cities = citiesResult else {
            return UITableViewCell()
        }
        
        let city = cities[indexPath.row]
        cell.titleLabel.text = city.name

        cell.descriptionLabel.text = "🌡\(String(format: "%.1f", city.celsius))℃ 💦 \(city.humidity)%"
        return cell
    }
}

extension MeteoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cities = citiesResult else { return }
        let vc = CityDetailsViewController()
        vc.city = cities[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .normal, title: "✕\nRemove ") { (rowAction:UITableViewRowAction, indexPath: IndexPath) -> Void in
            let realm = try! Realm()
            guard let cities = self.citiesResult else { return }
            let city = cities[indexPath.row]
            try! realm.write {
                realm.delete(city)
            }
        }
        deleteAction.backgroundColor = .red
        return [deleteAction]
    }
    
}
