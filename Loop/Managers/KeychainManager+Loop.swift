//
//  KeychainManager+Loop.swift
//  Loop
//
//  Created by Nate Racklyeft on 6/26/16.
//  Copyright © 2016 Nathan Racklyeft. All rights reserved.
//

import Foundation
import LoopKit


private let NightscoutAccount = "NightscoutAPI"
private let NightscoutAccountSecondary = "NightscoutAPISecondary"


extension KeychainManager {
    func setNightscoutURL(_ url: URL?, secret: String?) {
        let credentials: InternetCredentials?

        if let url = url, let secret = secret {
            credentials = InternetCredentials(username: NightscoutAccount, password: secret, url: url)
        } else {
            credentials = nil
        }

        do {
            try replaceInternetCredentials(credentials, forAccount: NightscoutAccount)
        } catch {
        }
    }

    func setNightscoutURLSecondary(_ url: URL?, secret: String?) {
        let credentials: InternetCredentials?

        if let url = url, let secret = secret {
            credentials = InternetCredentials(username: NightscoutAccountSecondary, password: secret, url: url)
        } else {
            credentials = nil
        }

        do {
            try replaceInternetCredentials(credentials, forAccount: NightscoutAccountSecondary)
        } catch {
        }
    }

    func getNightscoutCredentials() -> (url: URL, secret: String)? {
        do {
            let credentials = try getInternetCredentials(account: NightscoutAccount)

            return (url: credentials.url, secret: credentials.password)
        } catch {
            return nil
        }
    }

    func getNightscoutCredentialsSecondary() -> (url: URL, secret: String)? {
        do {
            let credentials = try getInternetCredentials(account: NightscoutAccountSecondary)

            return (url: credentials.url, secret: credentials.password)
        } catch {
            return nil
        }
    }
}
