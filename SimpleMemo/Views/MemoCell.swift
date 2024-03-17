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
    
    var memo: Memo? {
        didSet {
            setupUI()
        }
    }
    
    // 클로저 방식으로 구현 (화면 이동을 cell이 아닌 ViewController 에서 해야하기 때문에)
    var updateButtonAction: (MemoCell) -> Void = { (sender) in }
    
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
    
    lazy var updateButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil.tip"), for: .normal)
        button.setTitle("수정하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        
        button.tintColor = .white
        button.backgroundColor = .systemPink
        
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        
        button.addTarget(
            self,
            action: #selector(updateButtonTapped),
            for: .touchUpInside
        )
        
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
    
    private func setupUI() {
        contentsLabel.text = memo?.contents
        dateLabel.text = memo?.dateString
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
    
    // 뷰 컨트롤러에서 전해준 동작 실행
    @objc func updateButtonTapped() {
        updateButtonAction(self)
    }
}
