import UIKit
import Foundation

final class InitialViewController: UIViewController {
    
    private var coordinator: Coordinator
    private let contentView: InitialView
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return  .lightContent
    }
    
    init(coordinator: Coordinator,
         contentView: InitialView = InitialView()) {
        self.coordinator = coordinator
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillLayoutSubviews() {
        setupNavigationControllerAttributes()
        bindActions()
        setupPickerAddPhotoButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        contentView.resetScanButtonAffineTransform()
        contentView.hideLoading()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        contentView.animateScan()
    }

    private func setupNavigationControllerAttributes() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func loadView() {
        super.view = contentView
    }
        
    private func bindActions() {
        contentView.didTapScanButton = didTapScanButton
    }
 
    private func didTapScanButton() {
        coordinator.openCamera()
    }
    
    private func setupPickerAddPhotoButton() {
        coordinator.pickerAddPhoto.delegate = self
        coordinator.pickerAddPhoto.sourceType = .photoLibrary //no device real, mudar para .camera
    }
}

extension InitialViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true, completion: {
                self.contentView.showLoading()
                let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
                self.coordinator.recognization?.goToWallet(image: image)
            })
    }
}

extension InitialViewController: ViewControllerDelegate {
    func goToWallet(amount: Int, percentage: String) {
        coordinator.goToWalletViewController(with: amount, percentage: percentage)
        contentView.hideLoading()
    }
}
