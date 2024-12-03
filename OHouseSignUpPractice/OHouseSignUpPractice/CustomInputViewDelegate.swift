//
//  CustomInputViewDelegate.swift
//  OHouseSignUpPractice
//
//  Created by Heeoh Son on 11/25/24.
//

import Foundation

protocol CustomInputViewDelegate {
    func inputDidEndEditing(in inputView: CustomInputView, newValue: String)
    
    func inputDidChange(in inputView: CustomInputView, newValue: String)
    
    func validateInput(of inputView: CustomInputView, input: String) -> Bool
    
}
