import UIKit

class WalletView: UIView {
    
    @TemplateView var repeatScan: UIButton
    @TemplateView var newScan: UIButton
    @TemplateView var tableView: UITableView
    
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
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.heightAnchor.constraint(equalToConstant: frame.height * 0.45),
            tableView.widthAnchor.constraint(equalToConstant: frame.width)
        ])

        NSLayoutConstraint.activate([
            repeatScan.topAnchor.constraint(equalTo: topAnchor,
                                            constant: (frame.height * 0.5)),
            repeatScan.heightAnchor.constraint(equalToConstant: frame.height * 0.15),
            repeatScan.widthAnchor.constraint(equalToConstant: frame.width * 0.8),
            repeatScan.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            newScan.topAnchor.constraint(equalTo: repeatScan.bottomAnchor,
                                         constant: (frame.height * 0.04)),
            newScan.heightAnchor.constraint(equalToConstant: frame.height * 0.15),
            newScan.widthAnchor.constraint(equalToConstant: frame.width * 0.8),
            newScan.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func setupTableView() {
        tableView.backgroundColor = .tccBlack
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDataSource
        tableView.register(SingleAmountTableCell.self,
                           forCellReuseIdentifier: "SingleAmountTableCell")
    }
    
    private func setupRepeatScan() {
        repeatScan.setTitle("Escanear próxima nota",
                            for: .normal)
        repeatScan.layer.cornerRadius = frame.width * 0.06
        repeatScan.backgroundColor = .tccSmallerViewBackground
        repeatScan.addAction(UIAction(handler: {(_) in
            self.didTapRepeatScan?()
        }), for: .touchUpInside)
    }

    private func setupNewScan() {
        newScan.setTitle("Começar nova contagem",
                         for: .normal)
        newScan.layer.cornerRadius = frame.width * 0.06
        newScan.backgroundColor = .tccSmallerViewBackground
        newScan.addAction(UIAction(handler: {(_) in
            self.didTapNewScan?()
        }), for: .touchUpInside)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}
