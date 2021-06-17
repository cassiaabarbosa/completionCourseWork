import UIKit

class WalletView: UIView {
    
    @TemplateView var repeatScan: UIButton
    @TemplateView var newScan: UIButton
    @TemplateView var tableView: UITableView
    
    private var heightConstraint: NSLayoutConstraint?
    
    var didTapRepeatScan: (() -> Void)?
    var didTapNewScan: (() -> Void)?
    
    var tableViewDelegate: UITableViewDelegate?
    var tableViewDataSource: UITableViewDataSource?
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = .tccBlack
        buildViewHierarchy()
        applyConstraints()
        setupNewScan()
        setupRepeatScan()
        backgroundColor = .tccBlack
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildViewHierarchy() {
        addSubview(tableView)
        addSubview(repeatScan)
        addSubview(newScan)
    }
    
    private func applyConstraints() {
        heightConstraint = tableView.heightAnchor.constraint(equalToConstant: 160)
        NSLayoutConstraint.activate([
            tableView.bottomAnchor.constraint(equalTo: repeatScan.topAnchor, constant: -30),
            heightConstraint!,
            tableView.widthAnchor.constraint(equalToConstant: frame.width)
        ])

        NSLayoutConstraint.activate([
            repeatScan.bottomAnchor.constraint(equalTo: newScan.topAnchor,
                                            constant: (frame.height * -0.05)),
            repeatScan.heightAnchor.constraint(equalToConstant: frame.height * 0.1),
            repeatScan.widthAnchor.constraint(equalToConstant: frame.width * 0.7),
            repeatScan.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            newScan.bottomAnchor.constraint(equalTo: bottomAnchor,
                                            constant: (frame.height * -0.15)),
            newScan.heightAnchor.constraint(equalToConstant: frame.height * 0.1),
            newScan.widthAnchor.constraint(equalToConstant: frame.width * 0.7),
            newScan.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func setupTableView() {
        tableView.backgroundColor = .tccBlack
        tableView.separatorColor = .clear
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDataSource
        tableView.register(SingleAmountTableCell.self,
                           forCellReuseIdentifier: SingleAmountTableCell.id)
        tableView.register(HeaderView.self,
                           forCellReuseIdentifier: HeaderView.id)
        tableView.indicatorStyle = .white
    }
    
    private func setupRepeatScan() {
        repeatScan.setTitle("Escanear próxima nota",
                            for: .normal)
        repeatScan.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        repeatScan.layer.cornerRadius = frame.width * 0.06
        repeatScan.backgroundColor = .tccSmallerViewBackground
        repeatScan.addAction(UIAction(handler: {(_) in
            self.didTapRepeatScan?()
        }), for: .touchUpInside)
    }

    private func setupNewScan() {
        newScan.setTitle("Começar nova contagem",
                         for: .normal)
        newScan.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
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
