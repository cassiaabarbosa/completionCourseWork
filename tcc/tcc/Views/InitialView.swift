import UIKit

class InitialView: UIView {
    
    @TemplateView var scanButton: ScanButton
    @TemplateView var scanText: UILabel
    @TemplateView var loadingIndicator: UIActivityIndicatorView
    @TemplateView var gradient: UIView
    
    var didTapScanButton: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        buildViewHierarchy()
        applyConstraints()
        setupScanButton()
        setupScanText()
        bindActions()
        setupLoadingIndicator()
        setupGradient()
        backgroundColor = .tccBlack
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildViewHierarchy() {
        addSubview(scanButton)
        addSubview(scanText)
        addSubview(gradient)
        addSubview(loadingIndicator)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            scanButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: frame.height * 0.1),
            scanButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            scanButton.widthAnchor.constraint(equalToConstant: frame.width * 0.7),
            scanButton.heightAnchor.constraint(equalToConstant: frame.width * 0.7)
        ])
        
        NSLayoutConstraint.activate([
            scanText.centerYAnchor.constraint(equalTo: centerYAnchor, constant: frame.height * -0.25),
            scanText.centerXAnchor.constraint(equalTo: centerXAnchor),
            scanText.widthAnchor.constraint(equalToConstant: frame.width * 0.8)
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
    
    private func setupScanButton() {
        scanButton.clipsToBounds = true
        scanButton.layer.cornerRadius = (frame.width * 0.7) / 2
        scanButton.setImage(UIImage(named: "colocar a imagem"), for: .normal)
        scanButton.addAction(UIAction(handler: {(_) in
            self.didTapScanButton?()
        }), for: .touchUpInside)
    }
    
    private func setupScanText() {
        scanText.text = "Começar contagem"
        scanText.numberOfLines = .zero
        scanText.textColor = .white
        scanText.font = UIFont.boldSystemFont(ofSize: 30)
        scanText.adjustsFontSizeToFitWidth = true
        scanText.textAlignment = .center
    }
    
    private func bindActions() {
        scanButton.didTap = didTapScanButton
    }
    
    func resetScanButtonAffineTransform() {
        scanButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
    }
    
    func animateScan() {
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       options: [.autoreverse, .repeat, .allowUserInteraction],
                       animations: {
                        self.scanButton.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
                       },
                       completion:  nil)
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
