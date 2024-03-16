//
//  MemoListViewController.swift
//  SimpleMemo
//
//  Created by 김성민 on 3/15/24.
//

import UIKit
import SnapKit

class MemoListViewController: UIViewController {
    
    private let tableView = UITableView()
    
    lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
        button.tintColor = .label
        
        return button
    }()
    
    // MARK: - MVVM
    
    let viewModel: MemoListViewModel
    
    init(viewModel: MemoListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavi()
        setupTableView()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func setupNavi() {
        title = viewModel.title
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(MemoCell.self, forCellReuseIdentifier: MemoCell.identifier)
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    @objc func addButtonTapped() {
        viewModel.goToDetailVC(currentVC: self, memo: nil)
    }
}

extension MemoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.memoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MemoCell.identifier,
            for: indexPath) as? MemoCell else { return UITableViewCell() }
        
        let memo = viewModel.memoList[indexPath.row]
        let memoVM = viewModel.makeMemoVM(memo: memo)
        cell.viewModel = memoVM
        
        cell.selectionStyle = .none
        return cell
    }
}
