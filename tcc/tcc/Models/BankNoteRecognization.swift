import UIKit
import CoreML
import Vision
import ImageIO

class BankNoteRecognization {
    
    weak var delegate: ViewControllerDelegate?
    var aux = 0

    init(delegate: ViewControllerDelegate?) {
        self.delegate = delegate
    }
    
    func goToWallet(image: UIImage) {
        updateClassifications(for: image)
    }
    
    private func doRecognization(identifier: String) -> Int {
        switch translate(identifier: identifier) {
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
    
    private func translate(identifier: String) -> RealBankNote {
        if identifier == "2reais" { return RealBankNote.two }
        else if identifier == "5reais" { return RealBankNote.five }
        else if identifier == "10reais" { return RealBankNote.ten }
        else if identifier == "20reais" { return RealBankNote.twenty }
        else if identifier == "50reais" { return RealBankNote.fifty }
        else if identifier == "100reais" { return RealBankNote.hundred }
        else if identifier == "200reais" { return RealBankNote.twoHundred }
        else { return RealBankNote.zero }
    }
    
    private func translate(confidence: Float) -> String {
        return String(round(confidence * 1000) / 10.0).replacingOccurrences(of: ".", with: ",")
    }

    lazy var classificationRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: MyImageClassifier().model)
            
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                self?.processClassifications(for: request, error: error)
            })
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
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
                delegate?.goToWallet(amount: self.doRecognization(identifier: "zero"), percentage: "")
                return
            }
            if results.isEmpty {
                print("Unable to classify image.\n\(String(describing: error?.localizedDescription))")
                delegate?.goToWallet(amount: self.doRecognization(identifier: "zero"), percentage: "")
            } else {
                let topClassification = results[0]
                delegate?.goToWallet(amount: self.doRecognization(identifier: (topClassification as AnyObject).identifier ?? "0"), percentage: translate(confidence: Float((topClassification as AnyObject).confidence ?? 0)))
            }
        }
    }
}
