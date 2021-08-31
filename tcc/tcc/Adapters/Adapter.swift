import Foundation

struct Adapter {
    
    func translate(identifier: String) -> RealBankNote {
        if identifier == "2Reais" { return RealBankNote.two }
        else if identifier == "5Reais" { return RealBankNote.five }
        else if identifier == "10Reais" { return RealBankNote.ten }
        else if identifier == "20Reais" { return RealBankNote.twenty }
        else if identifier == "50Reais" { return RealBankNote.fifty }
        else if identifier == "100Reais" { return RealBankNote.hundred }
        else if identifier == "200Reais" { return RealBankNote.twoHundred }
        else { return RealBankNote.zero }
    }
    
    func translate(confidence: Float) -> String {
        return String(round(confidence * 1000) / 10.0).replacingOccurrences(of: ".", with: ",")
    }
}

