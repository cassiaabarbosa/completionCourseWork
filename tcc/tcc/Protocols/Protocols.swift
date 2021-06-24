import  UIKit
protocol ViewControllerDelegate: AnyObject {
    
    func goToWallet(amount: Int, percentage: String)
}
