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
        textLabel?.numberOfLines = 0
        textLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        textLabel?.adjustsFontForContentSizeCategory = true
        textLabel?.textAlignment = .left
        textLabel?.accessibilityTraits = .staticText
    }

    func show(text: String) {
        textLabel?.text = text
        textLabel?.textAlignment = .left
    }
}
