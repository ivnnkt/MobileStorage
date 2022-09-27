//Exitek iOS Developer Tech Task

// Implement mobile phone storage protocol
// Requirements:
// - Mobiles must be unique (IMEI is an unique number)
// - Mobiles must be stored in memory

import UIKit

protocol MobileStorage {
    func getAll() -> Set<Mobile>
    func findByImei(_ imei: String) -> Mobile?
    func save(_ mobile: Mobile) throws -> Mobile
    func delete(_ product: Mobile) throws
    func exists(_ product: Mobile) -> Bool
}

struct Mobile: Hashable {
    let imei: String
    let model: String
}

enum StorageError: Error {
    case phoneAlredyExist
    case phoneNotFound
}

class MobilePhoneStorage: MobileStorage {
    
    private var mobilePhones: Set<Mobile> = []
    
    func getAll() -> Set<Mobile> {
        return mobilePhones
    }
    
    func findByImei(_ imei: String) -> Mobile? {
        mobilePhones.first { $0.imei == imei }
    }
    
    func save(_ mobile: Mobile) throws -> Mobile {
        let (response, newPhone) = mobilePhones.insert(mobile)
        if response {
            return newPhone
        } else {
            throw StorageError.phoneAlredyExist
        }
    }
    
    func delete(_ product: Mobile) throws {
        if mobilePhones.remove(product) == nil {
            throw StorageError.phoneNotFound
        }
    }
    
    func exists(_ product: Mobile) -> Bool {
        mobilePhones.contains(product)
    }
}
