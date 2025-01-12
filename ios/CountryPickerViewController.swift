//
//  CountryPickerViewController.swift
//  react-native-turbo-country-picker
//
//  Created by VLAD on 12.01.2025.
//


import UIKit

protocol CountryPickerDelegate: AnyObject {
    func didSelectCountry(_ country: String)
}


struct CountryData {
    static let countries: [String] = [
        "🇦🇫 Afghanistan +93", "🇦🇱 Albania +355", "🇩🇿 Algeria +213", "🇦🇩 Andorra +376",
        "🇦🇴 Angola +244", "🇦🇬 Antigua and Barbuda +1-268", "🇦🇷 Argentina +54",
        "🇦🇲 Armenia +374", "🇦🇺 Australia +61", "🇦🇹 Austria +43", "🇦🇿 Azerbaijan +994",
        "🇧🇸 Bahamas +1-242", "🇧🇭 Bahrain +973", "🇧🇩 Bangladesh +880", "🇧🇧 Barbados +1-246",
        "🇧🇾 Belarus +375", "🇧🇪 Belgium +32", "🇧🇿 Belize +501", "🇧🇯 Benin +229",
        "🇧🇹 Bhutan +975", "🇧🇴 Bolivia +591", "🇧🇦 Bosnia and Herzegovina +387",
        "🇧🇼 Botswana +267", "🇧🇷 Brazil +55", "🇧🇳 Brunei +673", "🇧🇬 Bulgaria +359",
        "🇧🇫 Burkina Faso +226", "🇧🇮 Burundi +257", "🇨🇻 Cabo Verde +238", "🇰🇭 Cambodia +855",
        "🇨🇲 Cameroon +237", "🇨🇦 Canada +1", "🇨🇫 Central African Republic +236",
        "🇹🇩 Chad +235", "🇨🇱 Chile +56", "🇨🇳 China +86", "🇨🇴 Colombia +57", "🇰🇲 Comoros +269",
        "🇨🇩 Congo (Democratic Republic) +243", "🇨🇬 Congo (Republic) +242", "🇨🇷 Costa Rica +506",
        "🇭🇷 Croatia +385", "🇨🇺 Cuba +53", "🇨🇾 Cyprus +357", "🇨🇿 Czech Republic +420",
        "🇩🇰 Denmark +45", "🇩🇯 Djibouti +253", "🇩🇲 Dominica +1-767", "🇩🇴 Dominican Republic +1-809",
        "🇪🇨 Ecuador +593", "🇪🇬 Egypt +20", "🇺🇦 Ukraine +380", "🇬🇧 United Kingdom +44", "🇺🇸 United States +1"
    ]
}

@objc public class CountryPickerViewController: UIViewController {
    
    weak var delegate: CountryPickerDelegate?
    
    private let countries: [String] = CountryData.countries

    private var filteredCountries: [String] = []
    
    private var isSearching = false

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        
        searchBar.placeholder = "Search Country"
        searchBar.showsCancelButton = true
        searchBar.returnKeyType = .done
        searchBar.enablesReturnKeyAutomatically = true
        
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        setupDismissKeyboardOnTap()
    }
    
    private func setupUI() {
        view.addSubview(searchBar)
        view.addSubview(tableView)

        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    private func setupDismissKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension CountryPickerViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredCountries.count : countries.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let text = isSearching ? filteredCountries[indexPath.row] : countries[indexPath.row]
        
        cell.textLabel?.text = text
        cell.textLabel?.textAlignment = .left
        cell.selectionStyle = .none

        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountry = isSearching ? filteredCountries[indexPath.row] : countries[indexPath.row]
        
        delegate?.didSelectCountry(selectedCountry)
        dismiss(animated: true)
    }
}

extension CountryPickerViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredCountries.removeAll()
        } else {
            isSearching = true
            filteredCountries = countries.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
        tableView.reloadData()
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        isSearching = false
        filteredCountries.removeAll()
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }
}

