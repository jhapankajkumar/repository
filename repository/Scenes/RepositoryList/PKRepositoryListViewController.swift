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
        viewModel.fetchRepositoryList()
    }
}

extension PKRepositoryListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsAt(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    func viewModelDidFinishWithSuccess() {}
    
    func viewModelDidFinishWith(error: PKNetworkError) {}
}
