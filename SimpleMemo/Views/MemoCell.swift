//
//  MemoCell.swift
//  SimpleMemo
//
//  Created by 김성민 on 3/15/24.
//

import UIKit
import SnapKit

class MemoCell: UITableViewCell {
    
    static let identifier = "MemoCell"
    
    var viewModel: MemoViewModel! {
        didSet {
            setupUI()
        }
    }
    
    // MARK: - UI 구현
    
    let contentsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        
        return label
    }()
    
    let updateButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil.tip"), for: .normal)
        button.setTitle("수정하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        
        button.backgroundColor = .systemPink
        button.tintColor = .white
        
        // 버튼 둥글게 만들기
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    let backView = UIView()
    
    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        
        return stackView
    }()
    

    // MARK: - 생성자
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupStackView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 뷰모델을 이용한 뷰 세팅
    private func setupUI() {
        contentsLabel.text = viewModel.memo?.contents
        dateLabel.text = viewModel.memo?.dateString
    }
    
    private func setupStackView() {
        backView.addSubview(dateLabel)
        backView.addSubview(updateButton)
        mainStackView.addArrangedSubview(contentsLabel)
        mainStackView.addArrangedSubview(backView)
        contentView.addSubview(mainStackView)
    }
    
    private func setupLayout() {
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(backView.snp.leading)
            $0.bottom.equalTo(backView.snp.bottom)
            $0.trailing.equalTo(updateButton.snp.leading)
            $0.height.equalTo(40.0)
        }
        
        updateButton.snp.makeConstraints {
            $0.trailing.equalTo(backView.snp.trailing)
            $0.bottom.equalTo(backView.snp.bottom)
            $0.height.equalTo(40.0)
            $0.width.equalTo(100.0)
        }
        
        backView.snp.makeConstraints {
            $0.height.equalTo(60)
        }
    }
}
