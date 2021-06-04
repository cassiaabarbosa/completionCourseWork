import Foundation
import UIKit

final class Coordinator {
    var navigationController: LightNavigationController

    init(navigationController: LightNavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = ViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}

