import UIKit

class ScanButton: UIButton {
    
    @TemplateView var biggerView: UIView 
    
    @TemplateView var smallerView: UIView
    
    @TemplateView var logoView: UIImageView
    
    var didTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        buildViewHierarchy()
        applyConstraints()
        setupAcessibility()
        addAction(.init(handler: {_ in
            self.didTap?()
        }), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupBiggerView()
        setupSmallerView()
        setupLogoView()
        self.backgroundColor = .blue
    }
    
    private func buildViewHierarchy() {
        addSubview(biggerView)
        addSubview(smallerView)
        addSubview(logoView)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            biggerView.topAnchor.constraint(equalTo: self.topAnchor),
            biggerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            biggerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            biggerView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            smallerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            smallerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            smallerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            smallerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
        ])

        NSLayoutConstraint.activate([
            logoView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            logoView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            logoView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
        ])
    }
    
    private func setupBiggerView() {
        biggerView.clipsToBounds = true
        biggerView.layer.cornerRadius = biggerView.bounds.size.width / 2
        biggerView.backgroundColor = .tccBiggerViewBackground
        biggerView.isUserInteractionEnabled = false
    }
    
    private func setupSmallerView() {
        smallerView.clipsToBounds = true
        smallerView.layer.cornerRadius = smallerView.bounds.size.width / 2
        smallerView.backgroundColor = .tccSmallerViewBackground
        smallerView.isUserInteractionEnabled = false
    }
    
    private func setupLogoView() {
        logoView.image = UIImage()
        logoView.backgroundColor = .red
        logoView.isUserInteractionEnabled = false
    }
    
    private func setupAcessibility(){
        self.accessibilityTraits = .button
        self.accessibilityLabel = "Escanear notas"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
