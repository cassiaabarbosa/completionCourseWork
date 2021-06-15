import UIKit

class BankNoteRecognization {
    
    weak var delegate: ViewControllerDelegate?

    init(delegate: ViewControllerDelegate?) {
        self.delegate = delegate
    }
    
    func goToWallet() {
        delegate?.goToWallet(with: doRecognization())
    }
    
    private func doRecognization() -> Int {
        //TODO: Aqui será feito o reconhecimento das notas e sua consequente soma
        let range = [2, 5, 10, 20, 50, 100, 200]
        let elem = range.randomElement() ?? 0
        return elem
    }
}
