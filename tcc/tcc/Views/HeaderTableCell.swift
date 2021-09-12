import UIKit

class HeaderTableCell: UITableViewCell {
    
    static var id: String {
        return String(describing: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
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
        textLabel?.accessibilityTraits = .header
        detailTextLabel?.textColor = .white
        detailTextLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        detailTextLabel?.textAlignment = .left
        detailTextLabel?.numberOfLines = 0
        detailTextLabel?.accessibilityTraits = .staticText
        detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        detailTextLabel?.adjustsFontForContentSizeCategory = true
    }

    func show(text: String, detailText: String) {
        textLabel?.text = text
        detailTextLabel?.text = detailText
        
    }
}
