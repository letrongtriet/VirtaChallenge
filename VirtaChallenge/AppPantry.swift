//
//  AppPantry.swift
//  VirtaChallenge
//
//  Created by Triet Le on 2.6.2020.
//  Copyright © 2020 Le Trong Triet. All rights reserved.
//

import UIKit

struct AppPantry {
    
    struct Network {
        static let baseUrl = "https://apitest.virta.fi/v4"
    }
    
    struct AppIcon {
        static let rightArrowIcon = UIImage(named: "icChevronRight")
        static let sadFeedbackIcon = UIImage(named: "icChevronRight")
        static let infoIcon = UIImage(named: "icInfo")
        static let lockIcon = UIImage(named: "icLock")
        static let navigateIcon = UIImage(named: "icNavigate")
        static let personIcon = UIImage(named: "icPerson")
        static let type2Icon = UIImage(named: "icType2")
        static let unknownIcon = UIImage(named: "icUnknown")
        static let closeIcon = UIImage(named: "icX")
        static let loginIcon = UIImage(named: "logIn")
    }
    
    struct UserPersistentKey {
        static let didLogin = "UserDidLogin"
        static let tokenExpireTime = "TokenExpireTime"
        static let token = "UserToken"
    }
    
}
