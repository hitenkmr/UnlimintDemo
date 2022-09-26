//
// Copyright © 2022 Hitender Kumar. All rights reserved.
//

import UIKit

class EdgeCaseView { }

class JokesViewController: UITableViewController {
    private enum Identifiers {
        static let jokeTableViewCell = "JokeTableViewCell"
    }
    
    private lazy  var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: .init(x: 0, y: 0, width: 100, height: 100))
        indicator.isHidden = false
        indicator.hidesWhenStopped = true
        indicator.style = .medium
        return indicator
    }()
    
    /// Whether data is currently loading or not
    private var isLoading = false
    
    /// Dimentions used for UI elements
    enum Dimensions {
        static let tableViewBottomInset: CGFloat = 100.0
        static let horizontalPadding: CGFloat = 20
        static let indicatorHeight: CGFloat = 50.0
        static let indicatorWidth: CGFloat = 50.0
    }
        
    /// View model associated with jokes screen
    private let viewModel: JokesViewModel = .init()
    
    /// Initlizer
    init(viewModel: JokesViewModel) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.configuration.design.background(tableView)
        viewModel.configuration.design.background(view)
        
        setUpRefreshControl()
        setUpTableView()
        setUpIndicator()
        
        viewModel.onError = { [weak self] in self?.showError($0) }
        viewModel.isLoading = { [weak self] in self?.toggleLoading($0) }
        viewModel.onJokeFetchSuccess = { [weak self] in
            self?.toggleLoading(false)
            self?.tableView.reloadData()
        }
        
        viewModel.getJoke()
        viewModel.scheduleJokeFetcher()
    }
    
    // MARK: - Private methods
    
    @objc
    private func loadData() {
        tableView.refreshControl?.endRefreshing()

        guard !isLoading else { return }
        
        self.tableView.reloadData()
        
        viewModel.getJoke()
    }
    
    private func setUpRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        guard let refreshControl = tableView.refreshControl else { return }
        
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    
    private func setUpTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Dimensions.horizontalPadding),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Dimensions.horizontalPadding),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.register(JokeTableViewCell.self,
                           forCellReuseIdentifier: String(describing: Identifiers.jokeTableViewCell))
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
    }
    
    private func setUpIndicator() {
        view.addSubview(indicator)
        indicator.center = view.center
        NSLayoutConstraint.activate([
            indicator.widthAnchor.constraint(equalToConstant: Dimensions.indicatorWidth),
            indicator.heightAnchor.constraint(equalToConstant: Dimensions.indicatorHeight),
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        view.bringSubviewToFront(indicator)
    }
    
    private func toggleLoading(_ isLoading: Bool) {
        self.isLoading = isLoading
        isLoading ? indicator.startAnimating() : indicator.stopAnimating()
    }
    
    private func showError(_ error: Jokes.Error) {
        assignError(error)
    }
}

extension JokesViewController {
    
    // MARK: - UITableViewDelegate
     
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.jokesViewMOdels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.jokeTableViewCell) as? JokeTableViewCell else { return UITableViewCell() }
        cell.configure(with: viewModel.jokesViewMOdels[indexPath.row])
        return cell
    }
    
}

// MARK: - Error Handling

extension JokesViewController {
    @objc
    private func tryAgainAction(_ sender: UIButton) {
        loadData()
    }
}

/// Confirming to `EdgeCasePresenter` for showing error as popup
extension JokesViewController: EdgeCasePresenter { }
