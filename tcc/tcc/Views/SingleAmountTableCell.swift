import UIKit

class SingleAmountTableCell: UITableViewCell {
    
    static var id: String {
        return String(describing: self)
    }

    @TemplateView var amount: UILabel
    
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
        contentView.addSubview(amount)
    }
    
    private func cellAttributes() {
        backgroundColor = .tccBlack
    }
    
    private func setupAmount() {
        amount.textColor = .white
        amount.textAlignment = .center
        amount.font = UIFont.boldSystemFont(ofSize: 20)
        amount.numberOfLines = 0
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            amount.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            amount.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            amount.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            amount.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func show(value: Int, amount: Int) {
        if amount > 1 {
            self.amount.text = "Há \(amount) notas de R$ \(value),00"
        } else {
            self.amount.text = "Há \(amount) nota de R$ \(value),00"
        }
    }
}
