//
//  MainViewController.swift
//  Lesson 2.6_HW1
//
//  Created by Kostya on 21.03.2022.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setNewBackgroundColor(red: CGFloat, green: CGFloat, blue: CGFloat)
}

class MainViewController: UIViewController {
    
    private var backgroundColor: CGColor!
    private let alpha: CGFloat = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundColor = CGColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.backgroundColor = backgroundColor
        settingsVC.delegate = self
    }
    
    private func refreshBackgroundColor() {
        view.layer.backgroundColor = backgroundColor
    }
}

extension MainViewController: SettingsViewControllerDelegate {
    func setNewBackgroundColor(red: CGFloat, green: CGFloat, blue: CGFloat) {
        backgroundColor = CGColor.init(
            red: red,
            green: green,
            blue: blue,
            alpha: alpha)
        refreshBackgroundColor()
    }
}
