//
//  BalanceViewModel.swift
//  NFTView
//
//  Created by Charlie Irawan on 7/4/23.
//

import Foundation

struct BalanceViewModel: Identifiable {
    private let info: EVMData
    
    init(info: EVMData) {
      self.info = info
    }
    
    var id: Int {
        return Int.random(in: 0..<100000)
    }
    
    var balance: Double {
        var doubleValue: Double = 0.0
        let result = info.result ?? ""
        if let intValue = Int(result.replacingOccurrences(of: "0x", with: ""), radix: 16) {
            print(intValue)
            doubleValue = Double(intValue) * 1e-18
        }
        return doubleValue
    }
}

extension BalanceViewModel: Hashable {
  static func == (lhs: BalanceViewModel, rhs: BalanceViewModel) -> Bool {
    return lhs.id == rhs.id
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(self.id)
  }
}
