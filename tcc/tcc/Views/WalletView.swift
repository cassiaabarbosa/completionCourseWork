import UIKit

class WalletView: UIView {
    
    @TemplateView var whatToDo: UILabel
    @TemplateView var repeatScan: UIButton
    @TemplateView var nextScan: UIButton
    @TemplateView var newScan: UIButton
    @TemplateView var tableView: UITableView
    
    private var heightConstraint: NSLayoutConstraint?
    
    var didTapNextScan: (() -> Void)?
    var didTapRepeatScan: (() -> Void)?
    var didTapNewScan: (() -> Void)?
    
    var tableViewDelegate: UITableViewDelegate?
    var tableViewDataSource: UITableViewDataSource?
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        buildViewHierarchy()
        applyConstraints()
        setupWhatToDo()
        setupNewScan()
        setupNextScan()
        setupRepeatScan()
        backgroundColor = .blue
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildViewHierarchy() {
        addSubview(tableView)
        addSubview(whatToDo)
        addSubview(repeatScan)
        addSubview(nextScan)
        addSubview(newScan)
    }
    
    private func applyConstraints() {
        heightConstraint = tableView.heightAnchor.constraint(equalToConstant: 160)
        NSLayoutConstraint.activate([
            tableView.bottomAnchor.constraint(equalTo: repeatScan.topAnchor, constant: -100),
            heightConstraint!,
            tableView.widthAnchor.constraint(equalToConstant: frame.width)
        ])

        NSLayoutConstraint.activate([
            whatToDo.bottomAnchor.constraint(equalTo: repeatScan.topAnchor,
                                             constant: (frame.height * -0.025)),
            whatToDo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: (frame.width * 0.1))
        ])
        
        NSLayoutConstraint.activate([
            repeatScan.bottomAnchor.constraint(equalTo: nextScan.topAnchor,
                                            constant: (frame.height * -0.05)),
            repeatScan.heightAnchor.constraint(equalToConstant: 70),
            repeatScan.widthAnchor.constraint(equalToConstant: frame.width * 0.8),
            repeatScan.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nextScan.bottomAnchor.constraint(equalTo: newScan.topAnchor,
                                            constant: (frame.height * -0.05)),
            nextScan.heightAnchor.constraint(equalToConstant: 70),
            nextScan.widthAnchor.constraint(equalToConstant: frame.width * 0.8),
            nextScan.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            newScan.bottomAnchor.constraint(equalTo: bottomAnchor,
                                            constant: (frame.height * -0.05)),
            newScan.heightAnchor.constraint(equalToConstant: 70),
            newScan.widthAnchor.constraint(equalToConstant: frame.width * 0.8),
            newScan.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func setupTableView() {
        tableView.backgroundColor = .red
        tableView.separatorColor = .clear
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDataSource
        tableView.register(SingleAmountTableCell.self,
                           forCellReuseIdentifier: SingleAmountTableCell.id)
        tableView.register(HeaderView.self,
                           forCellReuseIdentifier: HeaderView.id)
        tableView.indicatorStyle = .white
    }
    
    private func setupWhatToDo() {
        whatToDo.text = "O que deseja fazer?"
        whatToDo.font = UIFont.boldSystemFont(ofSize: 18)
        whatToDo.textAlignment = .left
        whatToDo.textColor = .white
    }
    
    private func setupRepeatScan() {
        repeatScan.setTitle("Fotografar mesma nota para substituir na contagem",
                            for: .normal)
        repeatScan.titleLabel?.lineBreakMode = .byWordWrapping
        repeatScan.titleLabel?.textAlignment = .center
        repeatScan.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        repeatScan.layer.cornerRadius = frame.width * 0.06
        repeatScan.backgroundColor = .tccSmallerViewBackground
        repeatScan.addAction(UIAction(handler: {(_) in
            self.didTapRepeatScan?()
        }), for: .touchUpInside)
    }
    
    private func setupNextScan() {
        nextScan.setTitle("Fotografar nova nota para continuar a contagem",
                         for: .normal)
        nextScan.titleLabel?.lineBreakMode = .byWordWrapping
        nextScan.titleLabel?.textAlignment = .center
        nextScan.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        nextScan.layer.cornerRadius = frame.width * 0.06
        nextScan.backgroundColor = .tccSmallerViewBackground
        nextScan.addAction(UIAction(handler: {(_) in
            self.didTapNextScan?()
        }), for: .touchUpInside)
    }
    
    private func setupNewScan() {
        newScan.setTitle("Encerrar contagem",
                         for: .normal)
        newScan.titleLabel?.lineBreakMode = .byWordWrapping
        newScan.titleLabel?.textAlignment = .center
        newScan.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        newScan.layer.cornerRadius = frame.width * 0.06
        newScan.backgroundColor = .tccSmallerViewBackground
        newScan.addAction(UIAction(handler: {(_) in
            self.didTapNewScan?()
        }), for: .touchUpInside)
    }
    
    private func setTableviewHeight() {
        if (tableView.contentSize.height + 30) < (safeAreaLayoutGuide.layoutFrame.height * 0.5) {
            heightConstraint?.constant = tableView.contentSize.height + 30
        } else {
            startTimerForShowScrollIndicator()
        }
    }
    
    private func startTimerForShowScrollIndicator() {
        Timer.scheduledTimer(timeInterval: 0.3,
                            target: self,
                            selector: #selector(self.showScrollIndicators),
                            userInfo: nil,
                            repeats: true)
    }
    
    @objc func showScrollIndicators() {
        UIView.animate(withDuration: 0.001) {
            self.tableView.flashScrollIndicators()
        }
        
    }
    func reloadData() {
        tableView.reloadData()
        setTableviewHeight()
    }
}
