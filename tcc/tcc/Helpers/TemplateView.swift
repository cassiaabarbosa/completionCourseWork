import UIKit

/// A `class` created in order to simplify the way to create views using View Code.
@propertyWrapper final class TemplateView<View: UIView> {
    
    private let view: View = {
        let view = View(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var wrappedValue: View {
        return view
    }
}
