import UIKit

struct BankNote {
    var value: Int
    var amount: Int
}

enum RealBankNote {
    case zero
    case two
    case five
    case ten
    case twenty
    case fifty
    case hundred
    case twoHundred
}
