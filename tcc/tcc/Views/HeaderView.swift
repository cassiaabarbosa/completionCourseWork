import UIKit

class HeaderView: UITableViewCell {
    
    static var id: String {
        return String(describing: self)
    }

    @TemplateView var text: UILabel
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildViewHierarchy()
        applyConstraints()
        cellAttributes()
        setupAmount()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildViewHierarchy() {
        contentView.addSubview(text)
    }
    
    private func cellAttributes() {
        backgroundColor = .tccBlack
    }
    
    private func setupAmount() {
        text.textColor = .white
        text.textAlignment = .center
        text.font = UIFont.boldSystemFont(ofSize: 20)
        text.numberOfLines = 0
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            text.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            text.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            text.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            text.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    func show(text: String) {
        self.text.text = text
    }
}
