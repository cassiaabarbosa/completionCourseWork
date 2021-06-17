import UIKit

class BankNoteRecognization {
    
    weak var delegate: ViewControllerDelegate?
    var aux = 0

    init(delegate: ViewControllerDelegate?) {
        self.delegate = delegate
    }
    
    func goToWallet() {
        delegate?.goToWallet(with: doRecognization())
    }
    
    private func doRecognization() -> Int {
        if aux > 5 {
            aux = 0
        } else {
            aux += 1
        }
      
        let range = [2, 5, 10, 20, 50, 100, 200]
        let elem = range[aux]
        return elem
    }
}
