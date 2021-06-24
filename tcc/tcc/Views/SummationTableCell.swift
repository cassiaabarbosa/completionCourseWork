import UIKit

class SummationTableCell: UITableViewCell {
    
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
        textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        textLabel?.numberOfLines = 0
        textLabel?.textAlignment = .left
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 70)
        ])
    }

    func show(text: String) {
        textLabel?.text = text
    }
}
