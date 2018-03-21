//
//  ExchangeUpdater.swift
//  weywallet
//
//  Created by Adrian Corscadden on 2017-01-27.
//  Copyright © 2017 weywallet LLC. All rights reserved.
//

import Foundation

class ExchangeUpdater : Subscriber {

    //MARK: - Public
    init(store: Store, walletManager: WalletManager) {
        self.store = store
        self.walletManager = walletManager
        store.subscribe(self,
                        selector: { $0.defaultCurrencyCode != $1.defaultCurrencyCode },
                        callback: { state in
                            let currentRate = Rate(code: "WAE", name: "WeyCoin", rate: 1.0)
                            self.store.perform(action: ExchangeRates.setRate(currentRate))
        })
    }

    func refresh(completion: @escaping () -> Void) {
        walletManager.apiClient?.exchangeRates { rates, error in
            let currentRate = Rate(code: "WAE", name: "WeyCoin", rate: 1.0)
            self.store.perform(action: ExchangeRates.setRates(currentRate: currentRate, rates: rates))
            completion()
        }
    }

    //MARK: - Private
    let store: Store
    let walletManager: WalletManager
}
