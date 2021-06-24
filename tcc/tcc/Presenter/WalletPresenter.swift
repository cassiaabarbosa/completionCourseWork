import UIKit

class WalletPresenter {
    
    private var amounts: [Int] = []
    var cells: [BankNote] = []
    
    func append(amount: Int) {
        amounts.append(amount)
        adapt(amounts: filterAmounts())
    }
    
    func removeOcurrence(amount: Int) {
        for index in 0..<amounts.count {
            if amounts[index] == amount {
                amounts.remove(at: index)
                break
            }
        }
    }
    
    func getTotalAmount() -> String {
        let totalAmount = amounts.reduce(0, +)
        let totalString = String(totalAmount) + ",00"
        return totalString
    }
    
    private func filterAmounts() -> [[Int]] {
        return [amounts.filter({$0 == 2}),
                amounts.filter({$0 == 5}),
                amounts.filter({$0 == 10}),
                amounts.filter({$0 == 20}),
                amounts.filter({$0 == 50}),
                amounts.filter({$0 == 100}),
                amounts.filter({$0 == 200})]
    }
    
    private func adapt(amounts: [[Int]]) {
        cells.removeAll()
        for index in amounts {
            if !index.isEmpty {
                let value = index.first ?? 0
                let amount = index.count
                cells.append(BankNote(value: value, amount: amount))
            }
        }
    }
}
