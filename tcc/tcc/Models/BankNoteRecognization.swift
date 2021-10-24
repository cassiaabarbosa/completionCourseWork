import UIKit
import CoreML
import Vision

final class BankNoteRecognization {
    
    weak var delegate: ViewControllerDelegate?
    var aux = 0
    let adapter: Adapter

    init(delegate: ViewControllerDelegate?,
         adapter: Adapter = Adapter()) {
        self.delegate = delegate
        self.adapter = adapter
    }
    
    func goToWallet(image: UIImage) {
        updateClassifications(for: image)
    }
    
    private func doRecognization(identifier: String) -> Int {
        switch adapter.translate(identifier: identifier) {
        case .two:
            return 2
        case .five:
            return 5
        case .ten:
            return 10
        case .twenty:
            return 20
        case .fifty:
            return 50
        case .hundred:
            return 100
        case .twoHundred:
            return 200
        case .zero:
            return 0
        }
    }

    lazy var classificationRequest: VNCoreMLRequest = {
        
        let myModel: BillsClassification = try! BillsClassification(configuration: MLModelConfiguration.init())

        guard let model = try? VNCoreMLModel(for: myModel.model) else { fatalError() }
        
        let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
            self?.processClassifications(for: request, error: error)
        })
        request.imageCropAndScaleOption = .centerCrop
        return request
    }()

    func updateClassifications(for image: UIImage) {
        let orientation = CGImagePropertyOrientation(image.imageOrientation)
        guard let ciImage = CIImage(image: image) else {return}
        
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
            do {
                try handler.perform([self.classificationRequest])
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
                self.delegate?.goToWallet(amount: self.doRecognization(identifier: "zero"), percentage: "")
            }
        }
    }

    func processClassifications(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async { [self] in
            guard let results = request.results else {
                print("Unable to classify image.\n\(String(describing: error?.localizedDescription))")
                delegate?.goToWallet(amount: self.doRecognization(identifier: "zero"),
                                     percentage: "")
                return
            }
            if results.isEmpty {
                print("Unable to classify image.\n\(String(describing: error?.localizedDescription))")
                delegate?.goToWallet(amount: self.doRecognization(identifier: "zero"),
                                     percentage: "")
            } else {
                let topClassification = results[0]
                delegate?.goToWallet(amount: self.doRecognization(identifier: (topClassification as AnyObject).identifier ?? "0"),
                                     percentage: adapter.translate(confidence: Float((topClassification as AnyObject).confidence ?? 0)))
            }
        }
    }
}
