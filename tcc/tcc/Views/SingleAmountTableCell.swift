import UIKit

class SingleAmountTableCell: UITableViewCell {
    
    static var id: String {
        return String(describing: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellAttributes()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func cellAttributes() {
        backgroundColor = .tccBlack
        textLabel?.textColor = .white
        textLabel?.textAlignment = .left
        textLabel?.numberOfLines = 0
        textLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        textLabel?.adjustsFontForContentSizeCategory = true
    }
    
    func show(value: Int, amount: Int) {
        if amount > 1 {
            self.textLabel?.text = "Há \(amount) notas de R$ \(value),00"
            self.textLabel?.textAlignment = .left
        } else {
            self.textLabel?.text = "Há \(amount) nota de R$ \(value),00"
            self.textLabel?.textAlignment = .left
        }
    }
}
