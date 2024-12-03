//
//  String+Ext.swift
//  OHouseSignUpPractice
//
//  Created by Heeoh Son on 11/26/24.
//

import Foundation

extension String {
    /// 정규표현식과 일치하는지 검사
    /// - Parameter regex: 정규표현식
    /// - Returns: 일치 여부
    func matchesRegex(_ regex: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let range = NSRange(location: 0, length: self.utf16.count)
            return regex.firstMatch(in: self, options: [], range: range) != nil
        } catch {
            print("정규표현식 오류: \(error.localizedDescription)")
            return false
        }
    }
}
