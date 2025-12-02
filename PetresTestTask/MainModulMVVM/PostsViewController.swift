//
//  PostsViewController.swift
//  PetresTestTask
//
//  Created by DimaTru on 26.11.2025.
//

import UIKit

final class PostsViewController: UIViewController {
    
    //MARK: - свойства
    private let tableView = UITableView()
    private var viewModel: PostViewModelProtocol = PostViewModel()
    private let refreshControl = UIRefreshControl()
    
    //MARK: - жизненный кицл
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
        setupRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchPosts()
    }
    
    //MARK: - настройка таблицы
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //MARK: - метод соединения viewModel и ViewController
    private func bindViewModel() {
        viewModel.onPostsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }
    }
    
    //MARK: - матод обработки ленты жестом
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    // селектор обработки жеста
    @objc private func didPullToRefresh() {
        viewModel.fetchPosts()
    }
}

    //MARK: - расширение для методов таблицы
extension PostsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell {
            let post = viewModel.posts[indexPath.row]
            cell.configuretorTableViewCell(post: post)
            return cell
        }
        return UITableViewCell()
    }
}
