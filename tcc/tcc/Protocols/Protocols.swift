import  UIKit
protocol ViewControllerDelegate: AnyObject {
    
    func goToWallet(with amount: Int)
}
