//
//  ApplicationBrain.swift
//  GuessTheNumberV2
//
//  Created by Admin on 20.11.2021.
//

import UIKit

class ApplicationBrain: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var numberToGuess: UITextField!
    
    @IBOutlet weak var outputGeneratedNumberByComputer: UILabel!
    
    var numberToGuessTransmittedVC2 = ""
    var numberToGuessTransmittedVC3 = ""
    
    @IBOutlet weak var outputResultComparisonWithComputer: UILabel!
    
    @IBOutlet weak var humanInputNumber: UITextField!
    
    @IBOutlet weak var outputResultComparisonWithHuman: UILabel!
    
    @IBOutlet weak var resultWinOrLoseOrDraw: UILabel!
    
    var attemsCounter = 0
    var counterVC2 = 0
    var counterVC3 = 0
    var counterVC4 = 0
    
    @IBOutlet weak var numberGuessedByComputer: UILabel!
    
    @IBOutlet weak var numberHumanAttempts: UILabel!
    
    @IBOutlet weak var numberComputerAttempts: UILabel!
    
    @IBOutlet weak var outputRound: UILabel!
    
    var outputRoundCounter = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Для ограничения текста
        numberToGuess?.delegate = self
        humanInputNumber?.delegate = self
        
        //Высвечиваем в Label кол-во попыток человека и компьютера
        numberGuessedByComputer?.text = String(counterVC2)
        numberHumanAttempts?.text = String(counterVC3)
        numberComputerAttempts?.text = String(counterVC4)
        
        //Провека кто угадал число за наименьшее кол-во попыток
        if counterVC4 > counterVC3 {
            resultWinOrLoseOrDraw?.text = "You win"
        } else if counterVC4 < counterVC3 {
            resultWinOrLoseOrDraw?.text = "You lose"
        } else if counterVC4 == counterVC3 {
            resultWinOrLoseOrDraw?.text = "Ничья"
        }
        
        outputRound?.text = String(outputRoundCounter)
    }
    
    //MARK: Ограничения ввода текста
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text?.count == 0 && string == "0" {
            return false
        }
        if ((textField.text!) + string).count > 3 {
            return false
        }
        return true
    }
    
    // MARK: Идем в VC2 где компьютер генерирует число
    @IBAction func nextToComputerGenerate(_ sender: Any) {
        
        //Передаем данные заданного числа во VC2
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc2 = storyboard.instantiateViewController(withIdentifier: "VC2") as? ApplicationBrain {
            vc2.numberToGuessTransmittedVC2 = numberToGuess.text!
            show(vc2, sender: nil)
        }
    }
    
    // MARK: Компьютер генерирует число
    @IBAction func computerGenerateNumber(_ sender: Any) {
        //Конвертируем из String в Int
        let numberToGuessInt = Int(numberToGuessTransmittedVC2) ?? 0
        var generatedNumberByComputerInt = Int(outputGeneratedNumberByComputer.text!) ?? 0
        //Компьютер генерирует число и сравнивает его с заданным
        if generatedNumberByComputerInt == 0 {
            generatedNumberByComputerInt = Int.random(in: 1...999)
            outputGeneratedNumberByComputer.text = String(generatedNumberByComputerInt)
            if generatedNumberByComputerInt < numberToGuessInt {
                attemsCounter += 1
                outputResultComparisonWithComputer.text = "<"
            } else if generatedNumberByComputerInt > numberToGuessInt {
                attemsCounter += 1
                outputResultComparisonWithComputer.text = ">"
            } else {
                outputResultComparisonWithComputer.text = "С 1 попытки!"
                //Передача данных о кол-ве попыток и заданном числе во VC3
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let vc4 = storyboard.instantiateViewController(withIdentifier: "VC3") as? ApplicationBrain {
                    vc4.counterVC2 += attemsCounter
                    vc4.numberToGuessTransmittedVC3 = numberToGuessTransmittedVC2
                    show(vc4, sender: nil)
                }
            }
        } else if generatedNumberByComputerInt > 0 {
            if generatedNumberByComputerInt < numberToGuessInt {
                generatedNumberByComputerInt = Int.random(in: (generatedNumberByComputerInt + 1)...numberToGuessInt)
                outputGeneratedNumberByComputer.text = String(generatedNumberByComputerInt)
                if generatedNumberByComputerInt < numberToGuessInt {
                    attemsCounter += 1
                    outputResultComparisonWithComputer.text = "<"
                } else if generatedNumberByComputerInt > numberToGuessInt {
                    attemsCounter += 1
                    outputResultComparisonWithComputer.text = ">"
                } else {
                    attemsCounter += 1
                    outputResultComparisonWithComputer.text = "Попытки \(attemsCounter)"
                    //Передача данных о кол-ве попыток и заданном числе во VC3
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let vc4 = storyboard.instantiateViewController(withIdentifier: "VC3") as? ApplicationBrain {
                        vc4.counterVC2 += attemsCounter
                        vc4.numberToGuessTransmittedVC3 = numberToGuessTransmittedVC2
                        show(vc4, sender: nil)
                    }
                }
            } else if generatedNumberByComputerInt > numberToGuessInt {
                generatedNumberByComputerInt = Int.random(in: numberToGuessInt...(generatedNumberByComputerInt - 1))
                outputGeneratedNumberByComputer.text = String(generatedNumberByComputerInt)
                if generatedNumberByComputerInt < numberToGuessInt {
                    attemsCounter += 1
                    outputResultComparisonWithComputer.text = "<"
                } else if generatedNumberByComputerInt > numberToGuessInt {
                    attemsCounter += 1
                    outputResultComparisonWithComputer.text = ">"
                } else {
                    attemsCounter += 1
                    outputResultComparisonWithComputer.text = "Попытки \(attemsCounter)"
                    //Передача данных о кол-ве попыток и заданном числе во VC3
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let vc4 = storyboard.instantiateViewController(withIdentifier: "VC3") as? ApplicationBrain {
                        vc4.counterVC2 += attemsCounter
                        vc4.numberToGuessTransmittedVC3 = numberToGuessTransmittedVC2
                        show(vc4, sender: nil)
                    }
                }
            }
        }
    }
    //MARK: По нажатию идет сравнение заданного числа с человеческим
    @IBAction func compareResultHuman(_ sender: Any) {
        //Человек генерирует число и сравнивает его с заданным
        let numberToGuessInt = Int(numberToGuessTransmittedVC3) ?? 0
        let humanInputNumber = humanInputNumber.text!
        let humanInputNumberInt = Int(humanInputNumber ) ?? 0
        if humanInputNumberInt == numberToGuessInt {
            attemsCounter += 1
            outputResultComparisonWithHuman.text = "(=) Попытки \(attemsCounter)"
            //Передача данных о кол-ве попыток в VC4
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let vc4 = storyboard.instantiateViewController(withIdentifier: "VC4") as? ApplicationBrain {
                vc4.counterVC3 += attemsCounter
                vc4.counterVC4 = counterVC2
                show(vc4, sender: nil)
            }
        } else if humanInputNumberInt  > numberToGuessInt {
            attemsCounter += 1
            outputResultComparisonWithHuman.text = ">"
        } else if humanInputNumberInt  < numberToGuessInt {
            attemsCounter += 1
            outputResultComparisonWithHuman.text = "<"
        }
    }
    //MARK: По нажатию переходим в VC для нового раунда
    @IBAction func goToNewRound(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "VC") as? ApplicationBrain {
            vc.outputRoundCounter += 1
            show(vc, sender: nil)
        }
    }
    //MARK: По нажатию переходим в стартовое окно игры
    @IBAction func goToNewGame(_ sender: Any) {
        let newVC = storyboard?.instantiateViewController(withIdentifier: "ViewController")
        present(newVC!, animated: true, completion: nil)
    }
}
