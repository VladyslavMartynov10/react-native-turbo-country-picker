//
//  CountryPickerImpl.swift
//  react-native-turbo-country-picker
//
//  Created by VLAD on 12.01.2025.
//

import Foundation
import React

@objc public class CountryPickerImpl: NSObject {
    let rootViewController = UIApplication.shared.connectedScenes
        .compactMap({ $0 as? UIWindowScene })
        .flatMap(\.windows)
        .first(where: { $0.isKeyWindow })?.rootViewController
    
    var onCountrySelect: ((String) -> Void)?
    
    @objc public func openPicker(onCountrySelect: @escaping (String) -> Void) -> Void {
        self.onCountrySelect = onCountrySelect
        
        guard let rootViewController else { return }
                       
        DispatchQueue.main.async {
            let countryPickerViewController = CountryPickerViewController()
                   
            countryPickerViewController.delegate = self
        
            if let sheet = countryPickerViewController.sheetPresentationController {
                sheet.detents = [.large()]
                sheet.prefersGrabberVisible = false
            }
            
            rootViewController.present(countryPickerViewController, animated: true)
        }
    }
}

extension CountryPickerImpl: CountryPickerDelegate {
 func didSelectCountry(_ country: String) {
     print("Selected Country: \(country)")
     
     self.onCountrySelect?(country)
     
     self.onCountrySelect = nil
 }
}
