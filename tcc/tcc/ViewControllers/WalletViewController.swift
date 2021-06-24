import UIKit

final class WalletViewController: UIViewController {
    
    private var coordinator: Coordinator
    private var addedAmount: Int
    private let contentView: WalletView
    private let presenter: WalletPresenter
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return  .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationControllerAttributes()
    }
    
    init(coordinator: Coordinator,
         addedAmount: Int,
         contentView: WalletView = WalletView(),
         presenter:WalletPresenter = WalletPresenter()) {
        self.coordinator = coordinator
        self.addedAmount = addedAmount
        self.contentView = contentView
        self.coordinator = coordinator
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        super.view = contentView
        setupPickerAddPhotoButton()
        setupInitialAmount()
        bindActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNavigationControllerAttributes() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    private func setupPickerAddPhotoButton() {
        coordinator.pickerAddPhoto.delegate = self
        coordinator.pickerAddPhoto.sourceType = .photoLibrary //no device real, mudar para .camera
    }
    
    private func bindActions() {
        contentView.didTapNewScan = didTapNewScan
        contentView.didTapRepeatScan = didTapRepeatScan
        contentView.didTapNextScan = didTapNextScan
    }

    private func didTapRepeatScan() {
        presenter.removeOcurrence(amount: addedAmount)
        coordinator.openCamera()
    }
    
    private func didTapNewScan() {
        coordinator.backToInitialViewController()
    }
    
    private func didTapNextScan() {
        coordinator.openCamera()
    }
    
    private func setupTableViewObjects() {
        contentView.tableViewDataSource = self
        contentView.tableViewDelegate = self
        contentView.setupTableView()
    }
    
    private func setupInitialAmount() {
        presenter.append(amount: addedAmount)
        setupTableViewObjects()
    }
    
    private func updateAmountValue(amount: Int) {
        presenter.append(amount: amount)
        addedAmount = amount
        DispatchQueue.main.async {
            self.contentView.reloadData()
        }
    }
}

extension WalletViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: {
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            self.coordinator.recognization?.goToWallet(image: image)
        })
    }
}

extension WalletViewController: ViewControllerDelegate {
    func goToWallet(with amount: Int) {
        updateAmountValue(amount: amount)
    }
}

extension WalletViewController: UITableViewDelegate {}

extension WalletViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.cells.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HeaderView.id, for: indexPath) as? HeaderView else {
                return UITableViewCell()
            }
            cell.show(text: "A quantia total é de R$ \(presenter.getTotalAmount())")
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SingleAmountTableCell.id, for: indexPath) as? SingleAmountTableCell else {
                return UITableViewCell()
            }
            cell.show(value: presenter.cells[indexPath.row - 1].value,
                      amount: presenter.cells[indexPath.row - 1].amount)
            cell.selectionStyle = .none
            return cell
        }
    }
}
