import UIKit

class WalletView: UIView {
    
    @TemplateView var repeatScan: UIButton
    @TemplateView var nextScan: UIButton
    @TemplateView var newScan: UIButton
    @TemplateView var tableView: UITableView
    @TemplateView var loadingIndicator: UIActivityIndicatorView
    @TemplateView var gradient: UIView
    
    
    var didTapNextScan: (() -> Void)?
    var didTapRepeatScan: (() -> Void)?
    var didTapNewScan: (() -> Void)?
    
    var tableViewDelegate: UITableViewDelegate?
    var tableViewDataSource: UITableViewDataSource?
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        buildViewHierarchy()
        applyConstraints()
        setupNewScan()
        setupNextScan()
        setupRepeatScan()
        setupLoadingIndicator()
        setupGradient()
        backgroundColor = .tccBlack
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildViewHierarchy() {
        addSubview(tableView)
        addSubview(repeatScan)
        addSubview(nextScan)
        addSubview(newScan)
        addSubview(gradient)
        addSubview(loadingIndicator)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            tableView.bottomAnchor.constraint(equalTo: repeatScan.topAnchor, constant: -32),
            tableView.widthAnchor.constraint(equalToConstant: frame.width)
        ])
        
        NSLayoutConstraint.activate([
            repeatScan.bottomAnchor.constraint(equalTo: nextScan.topAnchor,
                                            constant: -20),
            repeatScan.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/10),
            repeatScan.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.8),
            repeatScan.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nextScan.bottomAnchor.constraint(equalTo: newScan.topAnchor,
                                            constant: -20),
            nextScan.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/10),
            nextScan.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.8),
            nextScan.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            newScan.bottomAnchor.constraint(equalTo: bottomAnchor,
                                            constant: -32),
            newScan.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/10),
            newScan.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.8),
            newScan.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            gradient.leadingAnchor.constraint(equalTo: leadingAnchor),
            gradient.trailingAnchor.constraint(equalTo: trailingAnchor),
            gradient.bottomAnchor.constraint(equalTo: bottomAnchor),
            gradient.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicator.widthAnchor.constraint(equalToConstant: frame.width * 0.2),
            loadingIndicator.heightAnchor.constraint(equalToConstant: frame.width * 0.2)
        ])
    }
    
    private func setupLoadingIndicator() {
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .large
        loadingIndicator.color = .white
        loadingIndicator.isHidden = true
    }
    
    private func setupGradient() {
        gradient.backgroundColor = UIColor(white: 0, alpha: 0.5)
        gradient.isHidden = true
    }
    
    private func setupRepeatScan() {
        repeatScan.setTitle("Fotografar novamente", for: .normal)
        repeatScan.accessibilityHint = "Fotografar mesma nota e modificar valor recém reconhecido."
        repeatScan.titleLabel?.lineBreakMode = .byWordWrapping
        repeatScan.titleLabel?.textAlignment = .center
        repeatScan.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        repeatScan.titleLabel?.adjustsFontForContentSizeCategory = true
        repeatScan.layer.cornerRadius = 10
        repeatScan.backgroundColor = .tccSmallerViewBackground
        repeatScan.addAction(UIAction(handler: {(_) in
            self.didTapRepeatScan?()
        }), for: .touchUpInside)
    }
    
    private func setupNextScan() {
        nextScan.setTitle("Continuar contagem", for: .normal)
        nextScan.accessibilityTraits = .button
        nextScan.accessibilityHint = "Fotografar uma nova nota para continuar a contagem."
        nextScan.titleLabel?.lineBreakMode = .byWordWrapping
        nextScan.titleLabel?.textAlignment = .center
        nextScan.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        nextScan.titleLabel?.adjustsFontForContentSizeCategory = true
        nextScan.layer.cornerRadius = 10
        nextScan.backgroundColor = .tccSmallerViewBackground
        nextScan.addAction(UIAction(handler: {(_) in
            self.didTapNextScan?()
        }), for: .touchUpInside)
    }
    
    private func setupNewScan() {
        newScan.setTitle("Voltar para o início", for: .normal)
        newScan.accessibilityTraits = .button
        newScan.accessibilityHint = "Encerrar contagem e voltar para o início."
        newScan.titleLabel?.lineBreakMode = .byWordWrapping
        newScan.titleLabel?.textAlignment = .center
        newScan.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        newScan.titleLabel?.adjustsFontForContentSizeCategory = true
        newScan.layer.cornerRadius = 10
        newScan.backgroundColor = .tccSmallerViewBackground
        newScan.addAction(UIAction(handler: {(_) in
            self.didTapNewScan?()
        }), for: .touchUpInside)
    }
    
    
    private func setupAcessibility (){
        self.accessibilityElements = [tableView,repeatScan,nextScan,newScan]
    }
    
    private func setTableviewHeight() {
        if (tableView.contentSize.height) > (safeAreaLayoutGuide.layoutFrame.height * 0.3) {
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

    func setupTableView() {
        tableView.backgroundColor = .tccBlack
        tableView.separatorColor = .clear
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDataSource
        tableView.register(SingleAmountTableCell.self,
                           forCellReuseIdentifier: SingleAmountTableCell.id)
        tableView.register(SummationTableCell.self,
                           forCellReuseIdentifier: SummationTableCell.id)
        tableView.register(HeaderTableCell.self,
                           forCellReuseIdentifier: HeaderTableCell.id)
        tableView.indicatorStyle = .white
    }
    
    func showLoading() {
        loadingIndicator.startAnimating()
        loadingIndicator.isHidden = false
        gradient.isHidden = false
    }

    func hideLoading() {
        loadingIndicator.stopAnimating()
        gradient.isHidden = true
    }
}
