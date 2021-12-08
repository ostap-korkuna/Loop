//
//  RemoteDataManager.swift
//  Loop
//
//  Created by Nate Racklyeft on 6/29/16.
//  Copyright © 2016 Nathan Racklyeft. All rights reserved.
//

import Foundation
import LoopKit
import NightscoutUploadKit


final class RemoteDataManager {

    weak var delegate: RemoteDataManagerDelegate?

    var nightscoutService: NightscoutService {
        didSet {
            keychain.setNightscoutURL(nightscoutService.siteURL, secret: nightscoutService.APISecret)
            keychain.setNightscoutURLSecondary(nightscoutService.siteURLSecondary, secret: nightscoutService.APISecretSecondary)
            UIDevice.current.isBatteryMonitoringEnabled = true
            delegate?.remoteDataManagerDidUpdateServices(self)
        }
    }

    private let keychain = KeychainManager()

    init() {
        if let (siteURL, APISecret) = keychain.getNightscoutCredentials() {
            if let (siteURLSecondary, APISecretSecondary) = keychain.getNightscoutCredentialsSecondary() {
                nightscoutService = NightscoutService(siteURL: siteURL, APISecret: APISecret, siteURLSecondary: siteURLSecondary, APISecretSecondary: APISecretSecondary)
            } else {
                nightscoutService = NightscoutService(siteURL: siteURL, APISecret: APISecret, siteURLSecondary: nil, APISecretSecondary: nil)
            }
            UIDevice.current.isBatteryMonitoringEnabled = true
        } else {
            nightscoutService = NightscoutService(siteURL: nil, APISecret: nil, siteURLSecondary: nil, APISecretSecondary: nil)
        }
    }
}


protocol RemoteDataManagerDelegate: AnyObject {
    func remoteDataManagerDidUpdateServices(_ dataManager: RemoteDataManager)
}
