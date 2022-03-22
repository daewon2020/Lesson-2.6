//
//  ViewController.swift
//  Lesson 2.2_HW1
//
//  Created by Kostya on 13.03.2022.
//

import UIKit


class SettingsViewController: UIViewController {

    @IBOutlet var colorView: UIView!
    
    @IBOutlet var greenColorValueLabel: UILabel!
    @IBOutlet var blueColorValueLabel: UILabel!
    @IBOutlet var redColorValueLabel: UILabel!
    
    @IBOutlet var redColorValueTF: UITextField!
    @IBOutlet var greenColorValueTF: UITextField!
    @IBOutlet var blueColorValueTF: UITextField!
    
    @IBOutlet var redColorSlider: UISlider!
    @IBOutlet var greenColorSlider: UISlider!
    @IBOutlet var blueColorSlider: UISlider!
    
    var backgroundColor: CGColor!
    var delegate: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let colorComponents = backgroundColor.components else { return }
        redColorSlider.value = Float(colorComponents[0])
        greenColorSlider.value = Float(colorComponents[1])
        blueColorSlider.value = Float(colorComponents[2])
        
        refreshColorValue(by: .slider, for: .red)
        refreshColorValue(by: .slider, for: .green)
        refreshColorValue(by: .slider, for: .blue)
        
        colorView.layer.cornerRadius = 15
        refreshViewColor()
        addDoneButtonOnKeyboard()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func doneAction() {
        if checkTextFieldsValue() {
            delegate.setNewBackgroundColor(
                red: CGFloat(redColorSlider.value),
                green: CGFloat(greenColorSlider.value),
                blue: CGFloat(blueColorSlider.value))
            dismiss(animated: true)
        }
    }
    
    @IBAction func sliderAction(_ sender: Any) {
        guard let slider = sender as? UISlider else { return }
        switch slider.restorationIdentifier {
        case "redSlider":
            refreshColorValue(by: .slider, for: .red)
        case "greenSlider":
            refreshColorValue(by: .slider, for: .green)
        default:
            refreshColorValue(by: .slider, for: .blue)
        }
        refreshViewColor()
    }
}

// MARK: -Private methods
extension SettingsViewController {
    private func refreshViewColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redColorSlider.value),
            green: CGFloat(greenColorSlider.value),
            blue: CGFloat(blueColorSlider.value),
            alpha: 1.0
        )
    }
    
    private func refreshColorValue(by sender: changedElement, for color: colorName) {
        if sender == .slider {
            switch color {
            case .red:
                redColorValueLabel.text = String(format: "%.2f", redColorSlider.value)
                redColorValueTF.text = redColorValueLabel.text
            case .green:
                greenColorValueLabel.text = String(format: "%.2f", greenColorSlider.value)
                greenColorValueTF.text = greenColorValueLabel.text
            case .blue:
                blueColorValueLabel.text = String(format: "%.2f", blueColorSlider.value)
                blueColorValueTF.text = blueColorValueLabel.text
            }
        } else {
            switch color {
            case .red:
                guard let redValue = Float(redColorValueTF.text ?? "0") else { return }
                redColorValueTF.text = String(format: "%.2f", redValue)
                redColorSlider.value = redValue
                redColorValueLabel.text = String(format: "%.2f", redValue)
            case .green:
                guard let greenValue = Float(greenColorValueTF.text ?? "0") else { return }
                greenColorValueTF.text = String(format: "%.2f", greenValue)
                greenColorSlider.value = greenValue
                greenColorValueLabel.text = String(format: "%.2f", greenValue)
            case .blue:
                guard let blueValue = Float(blueColorValueTF.text ?? "0") else { return }
                blueColorValueTF.text = String(format: "%.2f", blueValue)
                blueColorSlider.value = blueValue
                blueColorValueLabel.text = String(format: "%.2f", blueValue)
            }
        }
    }
    
    private func addDoneButtonOnKeyboard()
    {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
       
        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
            target: self,
            action: nil
        )
        let doneButton: UIBarButtonItem = UIBarButtonItem(
            title: "Done",
            style: UIBarButtonItem.Style.done,
            target: self,
            action: #selector(doneButtonAction)
        )
        
        toolBar.items = [flexSpace, doneButton]
        toolBar.sizeToFit()
        
        redColorValueTF.inputAccessoryView = toolBar
        greenColorValueTF.inputAccessoryView = toolBar
        blueColorValueTF.inputAccessoryView = toolBar
    }
    
    private func checkColorValue(for textNumber: String) -> Bool {
        guard let colorValue = Float(textNumber), (colorValue >= 0), (colorValue <= 1) else {
            showAlert(title: "Wrong value of color", message: "Color value must be >=0 ")
            return false
        }
        return true
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action  = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    private func checkTextFieldsValue() -> Bool {
        var checkPass = true
        if checkColorValue(for: redColorValueTF.text ?? "") {
            refreshColorValue(by: .textfield, for: .red)
        } else {
            refreshColorValue(by: .slider, for: .red)
            checkPass = false
        }
        
        if checkColorValue(for: greenColorValueTF.text ?? "") {
            refreshColorValue(by: .textfield, for: .green)
        }else {
            refreshColorValue(by: .slider, for: .green)
            checkPass = false
        }
        
        if checkColorValue(for: blueColorValueTF.text ?? "") {
            refreshColorValue(by: .textfield, for: .blue)
        }else {
            refreshColorValue(by: .slider, for: .blue)
            checkPass = false
        }
        return checkPass
    }
    
    @objc private func doneButtonAction() {
        if checkTextFieldsValue() {
            refreshViewColor()
            view.endEditing(true)
        }
    }
}

enum colorName {
    case red, green, blue
}

enum changedElement {
    case textfield, slider
}


