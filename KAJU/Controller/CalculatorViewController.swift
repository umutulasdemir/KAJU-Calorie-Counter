//
//  CalculatorViewController.swift
//  KAJU
//
//  Created by Duhan Boblanlı on 2.02.2023.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    
    var calorieSublabel = ""
    var bmh:Float = 1.2
    var changeCalorieAmount = 0
    var calculatorBrain = CalculatorBrain()
    var sex = "Male"
    var ColorDarkGreen = UIColor( red: 47/255, green: 136/255, blue: 134/255, alpha: 1)
    
    @IBOutlet weak var calculateButton: UIButton!
    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var ageSlider: UISlider!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    @IBOutlet weak var sexSegment: UISegmentedControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonStyle(button: calculateButton, cornerRadius: 0.096)
        calculateButton.isEnabled = false
        calculateButton.isHighlighted = true
    }
    
    @IBAction func sexSegmentPressed(_ sender: UISegmentedControl) {
        
        
        if sender.isSelected {
            sex = sender.titleForSegment(at:0)!
            sender.isSelected = false
        } else {
            sex = sender.titleForSegment(at: 1)!
            sender.isSelected = true
        }
        
        print(sex)
        calculateButton.backgroundColor = ColorDarkGreen
        calculateButton.isEnabled = true
        calculateButton.isHighlighted = false
    }
    
    
    // Text Label updates
    @IBAction func ageSliderChanged(_ sender: UISlider) {
        ageLabel.text = String(format: "%.0f", sender.value)
        calculateButton.backgroundColor = ColorDarkGreen
        calculateButton.isEnabled = true
        calculateButton.isHighlighted = false
    }
    @IBAction func hightSliderChanged(_ sender: UISlider) {
        heightLabel.text = String(format: "%.2f", sender.value) + "m"
        calculateButton.backgroundColor = ColorDarkGreen
        calculateButton.isEnabled = true
        calculateButton.isHighlighted = false
    }
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        weightLabel.text = String(format: "%.1f", sender.value) + "Kg"
        calculateButton.backgroundColor = ColorDarkGreen
        calculateButton.isEnabled = true
        calculateButton.isHighlighted = false
    }
    
    // Calculate Button
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        var age = ageSlider.value //35.69361
        age.round()
        let BMIheight = heightSlider.value // 1.5628742 metre
        var height = BMIheight * 100
        height.round()
        let weight = weightSlider.value //78.791916 kg

        calculatorBrain.calculateBMI(BMIheight,weight)
        calculatorBrain.calculateCalorie(sex,weight,height,age,bmh,changeCalorieAmount)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if segue.identifier == "goToResult" {
            // CalculatorResultVC field ve fonksiyonlara erişmek için downcasting
            let destinationVC = segue.destination as! CalculatorResultViewController
            destinationVC.bmiValue = calculatorBrain.getBMIValue()
            destinationVC.advice = calculatorBrain.getAdvice()
            destinationVC.color = calculatorBrain.getColor()
            destinationVC.CalorieSublabelField = calorieSublabel
            destinationVC.calorie = calculatorBrain.getCalorie()
            
        }
    }

    //Kenarlardan 10,height 72 constraintsli buttonlar için ideal cornerRadius 0.096
    func setupButtonStyle(button : UIButton,cornerRadius: Float){
        button.layer.cornerRadius = CGFloat(cornerRadius) * button.bounds.size.width
        button.clipsToBounds = true
    }
    
    
    
    
    
    
    
    
    
    
}
