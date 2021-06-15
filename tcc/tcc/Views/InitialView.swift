import UIKit

class InitialView: UIView {
    
    @TemplateView var scanButton: ScanButton
    @TemplateView var scanText: UILabel
    
    var didTapScanButton: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        buildViewHierarchy()
        applyConstraints()
        setupScanButton()
        setupScanText()
        bindActions()
        backgroundColor = .tccBlack
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildViewHierarchy() {
        addSubview(scanButton)
        addSubview(scanText)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            scanButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: frame.height * 0.1),
            scanButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            scanButton.widthAnchor.constraint(equalToConstant: frame.width * 0.7),
            scanButton.heightAnchor.constraint(equalToConstant: frame.width * 0.7)
        ])
        
        NSLayoutConstraint.activate([
            scanText.centerYAnchor.constraint(equalTo: centerYAnchor, constant: frame.height * -0.2),
            scanText.centerXAnchor.constraint(equalTo: centerXAnchor),
            scanText.widthAnchor.constraint(equalToConstant: frame.width * 0.7),
            scanText.heightAnchor.constraint(equalToConstant: frame.width * 0.7)
        ])
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
        scanText.text = "Clique para escanear"
        scanText.numberOfLines = .zero
        scanText.textColor = .white
        scanText.font = UIFont.boldSystemFont(ofSize: 30)
        scanText.adjustsFontSizeToFitWidth = true
        scanText.textAlignment = .center
    }
    
    private func bindActions() {
        scanButton.didTap = didTapScanButton
    }
}
