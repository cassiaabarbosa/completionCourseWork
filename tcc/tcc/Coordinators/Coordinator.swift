import Foundation
import UIKit

final class Coordinator {
    private var navigationController: LightNavigationController
    private var rootViewController: UIViewController?
    private var currentViewController: UIViewController?
    
    var recognization: BankNoteRecognization?
    var pickerAddPhoto = UIImagePickerController()
    
    init(navigationController: LightNavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = InitialViewController(coordinator: self)
        currentViewController = viewController
        navigationController.pushViewController(viewController,
                                                animated: true)
        rootViewController = viewController
        recognization = BankNoteRecognization(delegate: currentViewController  as? ViewControllerDelegate)
    }
    
    func openCamera() {
        recognization?.delegate = currentViewController as? ViewControllerDelegate
        currentViewController?.present(pickerAddPhoto,
                                       animated: true,
                                       completion: nil)
    }
    
    func goToWalletViewController(with amount: Int, percentage: String) {
        let viewController = WalletViewController(coordinator: self,
                                                  addedAmount: amount,
                                                  addedPercentage: percentage)
        currentViewController = viewController
        navigationController.pushViewController(viewController,
                                                animated: true)
    }
    
    func backToInitialViewController() {
        navigationController.popToRootViewController(animated: true)
        currentViewController = rootViewController
    }
}

