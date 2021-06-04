import UIKit

class LightNavigationController: UINavigationController {
    
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController?.childForStatusBarStyle ?? topViewController
    }
}
