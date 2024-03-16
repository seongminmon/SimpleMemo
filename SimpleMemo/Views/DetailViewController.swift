//
//  DetailViewController.swift
//  SimpleMemo
//
//  Created by 김성민 on 3/16/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - UI구현
    
    let contentsTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16)
        textView.layer.borderColor = UIColor.label.cgColor
        textView.layer.borderWidth = 1
        
        return textView
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPink
        
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    // MARK: - MVVM
    
    var viewModel: MemoViewModel
    
    init(viewModel: MemoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 라이프사이클
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavi()
        setupTextView()
        setupUI()
        setupLayout()
    }
    
    private func setupNavi() {
        title = viewModel.title
    }
    
    private func setupTextView() {
        contentsTextView.delegate = self
//        contentsTextView.becomeFirstResponder()
    }
    
    private func setupUI() {
        
    }
    
    private func setupLayout() {
        view.addSubview(contentsTextView)
        view.addSubview(saveButton)
        
        contentsTextView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(24.0)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(24.0)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(24.0)
            $0.height.equalTo(300.0)
        }
        
        saveButton.snp.makeConstraints {
            $0.top.equalTo(contentsTextView.snp.bottom).offset(40.0)
            $0.leading.equalToSuperview().inset(24.0)
            $0.trailing.equalToSuperview().inset(24.0)
            $0.height.equalTo(40.0)
        }
    }
    
    // 다른 화면 터치 시 키보드 내려가게 만들기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension DetailViewController: UITextViewDelegate {
    // TODO: - 플레이스 홀더 구현하기
}
