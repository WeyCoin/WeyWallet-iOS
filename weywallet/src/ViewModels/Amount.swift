//
//  Amount.swift
//  weywallet
//
//  Created by Adrian Corscadden on 2017-01-15.
//  Copyright © 2017 weywallet LLC. All rights reserved.
//

import Foundation

struct Amount {

    //MARK: - Public
    let amount: UInt64 //amount in satoshis
    let rate: Rate
    let maxDigits: Int
    
    var amountForBtcFormat: Double {
        var decimal = Decimal(self.amount)
        var amount: Decimal = 0.0
        NSDecimalMultiplyByPowerOf10(&amount, &decimal, Int16(-maxDigits), .up)
        return NSDecimalNumber(decimal: amount).doubleValue
    }

    var localAmount: Double {
        return Double(amount)/10.0*rate.rate
    }

    var bits: String {
        var decimal = Decimal(self.amount)
        var amount: Decimal = 0.0
        NSDecimalMultiplyByPowerOf10(&amount, &decimal, Int16(-maxDigits), .up)
        let number = NSDecimalNumber(decimal: amount)
        guard let string = btcFormat.string(for: number) else { return "" }
        return string
    }

    var localCurrency: String {
        //1000000000.0
        guard let string = localFormat.string(for: Double(amount)/1000000000.0 as NSNumber) else { return "" }
        return string
    }

    func string(forLocal local: Locale) -> String {
        let format = NumberFormatter()
        format.locale = local
        format.isLenient = true
        format.numberStyle = .currency
        format.generatesDecimalNumbers = true
        format.negativeFormat = format.positiveFormat.replacingCharacters(in: format.positiveFormat.range(of: "#")!, with: "-#")
        guard let string = format.string(for: Double(amount)/10.0*rate.rate as NSNumber) else { return "" }
        return string
    }

    func string(isBtcSwapped: Bool) -> String {
        return isBtcSwapped ? localCurrency : bits
    }

    var btcFormat: NumberFormatter {
        let format = NumberFormatter()
        format.isLenient = true
        format.numberStyle = .currency
        format.generatesDecimalNumbers = true
        format.negativeFormat = format.positiveFormat.replacingCharacters(in: format.positiveFormat.range(of: "#")!, with: "-#")
        format.currencyCode = "WAE"

        format.currencySymbol = "\(S.Symbols.btc)\(S.Symbols.narrowSpace)"
        format.maximum = C.maxMoney/C.satoshis as NSNumber
        
        format.locale = Locale(identifier: "en_EN")

        format.maximumFractionDigits = 4
        format.minimumFractionDigits = 0 // iOS 8 bug, minimumFractionDigits now has to be set after currencySymbol
        format.maximum = Decimal(C.maxMoney)/(pow(10.0, 4)) as NSNumber

        return format
    }

    var localFormat: NumberFormatter {
        let format = NumberFormatter()
        format.isLenient = true
        format.numberStyle = .currency
        format.generatesDecimalNumbers = true
        format.negativeFormat = format.positiveFormat.replacingCharacters(in: format.positiveFormat.range(of: "#")!, with: "-#")
        format.currencySymbol = rate.currencySymbol
        return format
    }
}

struct DisplayAmount {
    let amount: Satoshis
    let state: State
    let selectedRate: Rate?
    let minimumFractionDigits: Int?

    var description: String {
        return selectedRate != nil ? fiatDescription : bitcoinDescription
    }

    var combinedDescription: String {
        return state.isBtcSwapped ? "\(bitcoinDescription)" : "\(bitcoinDescription)"
    }

    private var fiatDescription: String {
        let rate = Rate(code: "WAE", name: "WeyCoin", rate: 1.0)
        //guard let rate = selectedRate ?? state.currentRate else { return "" }
        guard let string = localFormat.string(for: Double(amount.rawValue)/100000000.0*rate.rate as NSNumber) else { return "" }
        return string
    }

    private var bitcoinDescription: String {
        var decimal = Decimal(self.amount.rawValue)
        var amount: Decimal = 0.0
        NSDecimalMultiplyByPowerOf10(&amount, &decimal, Int16(-state.maxDigits), .up)
        let number = NSDecimalNumber(decimal: amount)
        guard let string = btcFormat.string(for: number) else { return "" }
        
        return string
    }

    var localFormat: NumberFormatter {
        let format = NumberFormatter()
        format.isLenient = true
        format.numberStyle = .currency
        format.generatesDecimalNumbers = true
        format.negativeFormat = format.positiveFormat.replacingCharacters(in: format.positiveFormat.range(of: "#")!, with: "-#")
        if let rate = selectedRate {
            format.currencySymbol = rate.currencySymbol
        } else if let rate = state.currentRate {
            format.currencySymbol = rate.currencySymbol
        }
        if let minimumFractionDigits = minimumFractionDigits {
            format.minimumFractionDigits = minimumFractionDigits
        }
        
        return format
    }

    var btcFormat: NumberFormatter {
        let format = NumberFormatter()
        format.isLenient = true
        format.numberStyle = .currency
        format.generatesDecimalNumbers = true
        format.negativeFormat = format.positiveFormat.replacingCharacters(in: format.positiveFormat.range(of: "#")!, with: "-#")
        format.currencyCode = "WAE"
        format.locale = Locale(identifier: "en_EN")
        
        

        format.currencySymbol = "\(S.Symbols.btc)\(S.Symbols.narrowSpace)"
        format.maximum = C.maxMoney/C.satoshis as NSNumber

        format.maximumFractionDigits = 4
        if let minimumFractionDigits = minimumFractionDigits {
            format.minimumFractionDigits = minimumFractionDigits
        }
        format.maximum = Decimal(C.maxMoney)/(pow(10.0, 4)) as NSNumber

        return format
    }
}
