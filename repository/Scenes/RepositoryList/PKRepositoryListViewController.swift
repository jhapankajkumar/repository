//
//  PKRepositoryListViewController.swift
//  repository
//
//  Created by pankaj.k.jha on 24/10/21.
//

import UIKit
import MaterialActivityIndicator
class PKRepositoryListViewController: UIViewController, PKRepositoryListViewProtocol {

    @IBOutlet weak var listTableView: UITableView!
    
    let viewModel: PKRepositoryListViewModelProtocol
    let indicator = MaterialActivityIndicatorView()
    required init(with viewModel: PKRepositoryListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Repositories"
        setupIndicator()
        indicator.startAnimating()
        setupTableView()
        listTableView.isHidden = true
        viewModel.fetchRepositoryList()
    }
    
    private func setupIndicator() {
        self.view.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .black
        indicator.widthAnchor.constraint(equalToConstant: 30).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: 30).isActive = true
        indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    private func setupTableView() {
        listTableView.register(PKRepositoryTableViewCell.self, forCellReuseIdentifier: PKRepositoryTableViewCell.identifier)
        listTableView.register(PKNextButtonTableViewCell.self, forCellReuseIdentifier: PKNextButtonTableViewCell.identifier)
        listTableView.rowHeight = UITableView.automaticDimension
        listTableView.estimatedRowHeight = 140
    }
    
    @objc
    func fetchNextRecords() {
        indicator.startAnimating()
        viewModel.fetchRepositoryList()
    }
}

extension PKRepositoryListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel.numberOfRowsAt(section: section)
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let data = viewModel.dataForRowAt(indexPath: indexPath) {
                if let cell = tableView.dequeueReusableCell(withIdentifier: PKRepositoryTableViewCell.identifier, for: indexPath) as? PKRepositoryTableViewCell {
                    cell.configureCell(viewModel: data)
                    return cell
                }
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PKNextButtonTableViewCell.identifier, for: indexPath) as? PKNextButtonTableViewCell {
                cell.nextButton.addTarget(self, action: #selector(fetchNextRecords), for: .touchUpInside)
                return cell
            }
        }
        return UITableViewCell()
    }
}

extension PKRepositoryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRowAt(indexPath: indexPath, fromView: self)
    }
}

extension PKRepositoryListViewController : PKRepositoryListViewModelDelegate {
    func viewModelDidFinishWithSuccess() {
        indicator.stopAnimating()
        listTableView.isHidden = false
        listTableView.reloadData()
    }
    
    func viewModelDidFinishWith(error: PKNetworkError) {
        indicator.stopAnimating()
        showAlert(with: "Bucket List", message: error.message)
    }
}
