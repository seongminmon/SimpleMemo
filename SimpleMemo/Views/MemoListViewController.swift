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
    
    private func setupNavi() {
        title = viewModel.title
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
    
}

extension MemoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.memoList.count
        
        // test
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MemoCell.identifier,
            for: indexPath) as? MemoCell else { return UITableViewCell() }
        
//        let memo = viewModel.memoList[indexPath.row]
//        let memoVM = viewModel.makeMemoVM(memo: memo)
//        cell.viewModel = memoVM
        
        // test
        cell.viewModel = MemoViewModel(dataManager: CoreDataManager.shared, memo: nil)
        
        cell.selectionStyle = .none
        return cell
    }
}
