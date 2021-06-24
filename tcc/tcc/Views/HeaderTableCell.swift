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
        textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        textLabel?.textAlignment = .left
        detailTextLabel?.textColor = .white
        detailTextLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        detailTextLabel?.textAlignment = .left
        detailTextLabel?.numberOfLines = 0
    }

    func show(text: String, detailText: String) {
        textLabel?.text = text
        detailTextLabel?.text = detailText
    }
}
