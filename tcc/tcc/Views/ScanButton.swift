import UIKit

class ScanButton: UIButton {
    
    @TemplateView var biggerView: UIView 
    
    @TemplateView var smallerView: UIView
    
    @TemplateView var logoView: UIImageView
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        buildViewHierarchy()
        applyConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupBiggerView()
        setupSmallerView()
        setupLogoView()
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
    }
    
    private func setupSmallerView() {
        smallerView.clipsToBounds = true
        smallerView.layer.cornerRadius = smallerView.bounds.size.width / 2
        smallerView.backgroundColor = .tccSmallerViewBackground
    }
    
    private func setupLogoView() {
        logoView.image = UIImage()
        logoView.backgroundColor = .red
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonAction() {
        print( "vai pra outra tela")
    }
    
    
}
