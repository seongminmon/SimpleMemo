//
//  MemoListViewController.swift
//  SimpleMemo
//
//  Created by 김성민 on 3/15/24.
//

import UIKit
import SnapKit

class MemoListViewController: UIViewController {
    
    // 코어데이터 모델
    let memoManager = CoreDataManager.shared
    
    // MARK: - UI 구현
    
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
    
    // MARK: - 라이프사이클
    
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
        title = "메모"
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
        goToDetailVC(memo: nil)
    }
    
    // 디테일뷰로 이동하는 함수 (메모 생성하기)
    private func goToDetailVC(memo: Memo?) {
        let detailVC = DetailViewController()
        detailVC.memo = memo
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MemoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoManager.getMemoList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MemoCell.identifier,
            for: indexPath) as? MemoCell else { return UITableViewCell() }
        
        let memo = memoManager.getMemoList()[indexPath.row]
        cell.memo = memo
        
        cell.updateButtonAction = { [weak self] (senderCell) in
            self?.goToDetailVC(memo: memo)
        }
        
        cell.selectionStyle = .none
        return cell
    }
}
