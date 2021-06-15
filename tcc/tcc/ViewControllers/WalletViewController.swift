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
        view.backgroundColor = .tccBlack
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
        navigationController?.navigationBar.barTintColor = .tccBlack
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.setHidesBackButton(true, animated: false)
    }

    private func setupPickerAddPhotoButton() {
        coordinator.pickerAddPhoto.delegate = self
        coordinator.pickerAddPhoto.sourceType = .photoLibrary //no device real, mudar para .camera
    }
    
    private func bindActions() {
        contentView.didTapNewScan = didTapNewScan
        contentView.didTapRepeatScan = didTapRepeatScan
    }

    private func didTapRepeatScan() {
        coordinator.openCamera()
    }
    
    private func didTapNewScan() {
        coordinator.backToInitialViewController()
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
        DispatchQueue.main.async {
            self.contentView.reloadData()
        }
    }
}

extension WalletViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: {
            self.coordinator.recognization?.goToWallet()
        })
    }
}

extension WalletViewController: ViewControllerDelegate {
    func goToWallet(with amount: Int) {
        updateAmountValue(amount: amount)
    }
}

extension WalletViewController: UITableViewDelegate {

}

extension WalletViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SingleAmountTableCell", for: indexPath) as? SingleAmountTableCell else {
            return UITableViewCell()
        }
        cell.show(value: presenter.cells[indexPath.row].value,
                  amount: presenter.cells[indexPath.row].amount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "A quantia total é de R$ \(presenter.getTotalAmount())"
    }
}
