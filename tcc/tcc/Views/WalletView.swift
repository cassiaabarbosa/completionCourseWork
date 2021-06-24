import UIKit

class WalletView: UIView {
    
    @TemplateView var whatToDo: UILabel
    @TemplateView var repeatScan: UIButton
    @TemplateView var nextScan: UIButton
    @TemplateView var newScan: UIButton
    @TemplateView var tableView: UITableView
    @TemplateView var loadingIndicator: UIActivityIndicatorView
    @TemplateView var gradient: UIView
    
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
        addSubview(whatToDo)
        addSubview(repeatScan)
        addSubview(nextScan)
        addSubview(newScan)
        addSubview(gradient)
        addSubview(loadingIndicator)
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
            whatToDo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: (frame.width * 0.05))
        ])
        
        NSLayoutConstraint.activate([
            repeatScan.bottomAnchor.constraint(equalTo: nextScan.topAnchor,
                                            constant: (frame.height * -0.05)),
            repeatScan.heightAnchor.constraint(equalToConstant: 50),
            repeatScan.widthAnchor.constraint(equalToConstant: 170),
            repeatScan.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nextScan.bottomAnchor.constraint(equalTo: newScan.topAnchor,
                                            constant: (frame.height * -0.05)),
            nextScan.heightAnchor.constraint(equalToConstant: 50),
            nextScan.widthAnchor.constraint(equalToConstant: 170),
            nextScan.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            newScan.bottomAnchor.constraint(equalTo: bottomAnchor,
                                            constant: (frame.height * -0.05)),
            newScan.heightAnchor.constraint(equalToConstant: 50),
            newScan.widthAnchor.constraint(equalToConstant: 170),
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
    
    private func setupWhatToDo() {
        whatToDo.text = "O que deseja fazer?"
        whatToDo.font = UIFont.boldSystemFont(ofSize: 20)
        whatToDo.textAlignment = .left
        whatToDo.textColor = .white
    }
    
    private func setupRepeatScan() {
        repeatScan.setTitle("Fotografar novamente", // na acassibilidade, seria bom que falasse além do nome do botão, "O valor da nota recém reconhecida será desconsiderado."
                            for: .normal)
        repeatScan.titleLabel?.lineBreakMode = .byWordWrapping
        repeatScan.titleLabel?.textAlignment = .center
        repeatScan.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        repeatScan.layer.cornerRadius = 10
        repeatScan.backgroundColor = .tccSmallerViewBackground
        repeatScan.addAction(UIAction(handler: {(_) in
            self.didTapRepeatScan?()
        }), for: .touchUpInside)
    }
    
    private func setupNextScan() {
        nextScan.setTitle("Continuar contagem", // na acassibilidade, seria bom que falasse além do nome do botão, "Uma nova nota deverá ser reconhecida."
                         for: .normal)
        nextScan.titleLabel?.lineBreakMode = .byWordWrapping
        nextScan.titleLabel?.textAlignment = .center
        nextScan.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        nextScan.layer.cornerRadius = 10
        nextScan.backgroundColor = .tccSmallerViewBackground
        nextScan.addAction(UIAction(handler: {(_) in
            self.didTapNextScan?()
        }), for: .touchUpInside)
    }
    
    private func setupNewScan() {
        newScan.setTitle("Encerrar contagem", // na acassibilidade, seria bom que falasse além do nome do botão, "Todos os valores serão apagados."
                         for: .normal)
        newScan.titleLabel?.lineBreakMode = .byWordWrapping
        newScan.titleLabel?.textAlignment = .center
        newScan.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        newScan.layer.cornerRadius = 10
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
