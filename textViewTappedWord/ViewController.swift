//
//  ViewController.swift
//  textViewTappedWord
//
//  Created by parth on 7/1/17.
//  Copyright © 2017 parthanand.com. All rights reserved.
//

import UIKit
import GameplayKit
import PickerController
import Alamofire
import SwiftyJSON
import KVLoading


class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var correctAnswerArray = [String]()
    var jumbledAnswersArray = [String]()
    var rightWrongArray = [String]()
    var l = [UILabel]()
    var clone_l = [UILabel]()
    var result = [String]()
    var startPos = [Int]()
    var endPos = [Int]()
    var score = 0
    static var level = ""
    var tap: UITapGestureRecognizer? = nil
    var s = ""
    var test = ""
    
    
    
    let textView: UITextView = {
    
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.boldSystemFont(ofSize: 10)
        text.isEditable = false
        text.isSelectable = false
        text.backgroundColor = .clear
        text.showsVerticalScrollIndicator = false
        return text
        
    }()
    
    let submitButton: UIButton = {
    
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 20)
        button.backgroundColor = UIColor(red: 63/255, green: 81/255, blue: 181/255, alpha: 0.9)

        return button
        
    }()
    
    let backgroundImage: UIImageView = {
    
        let background = UIImageView(image: #imageLiteral(resourceName: "white"))
        background.translatesAutoresizingMaskIntoConstraints = false
        background.contentMode = .scaleAspectFill
        return background
        
    }()
    
    let cancelButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "cancel").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    

    let newGameButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Replay", for: .normal)
        button.setTitleColor(UIColor(red: 63/255, green: 81/255, blue: 181/255, alpha: 0.9), for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir", size: 17)
        button.layer.borderColor = UIColor(red: 63/255, green: 81/255, blue: 181/255, alpha: 0.9).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        
        return button
        
    }()
    
    let scoreLabel: UILabel = {
    
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 63/255, green: 81/255, blue: 181/255, alpha: 0.9)
        label.textAlignment = .center
        label.text = "WordFill"
        label.font = UIFont(name: "Avenir-Heavy", size: 18)
        return label
        
    }()
    
    let viewCorrectAnswers: UIButton = {
    
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("View Correct Answers", for: .normal)
        button.setTitleColor(UIColor(red: 63/255, green: 81/255, blue: 181/255, alpha: 0.9), for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 20)
        button.layer.borderColor = UIColor(red: 63/255, green: 81/255, blue: 181/255, alpha: 0.9).cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    func rotated() {
        
        let yValue = (navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height
        
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            textView.frame = CGRect(x: 10, y: yValue, width: view.frame.width - 20, height: view.frame.height - (yValue+60))
            
            clone_l = l

            for i in 0..<l.count {
                
                l[i].removeFromSuperview()
            }
            
            l.removeAll()
            
            let pattern = "__________"
            let regex = try! NSRegularExpression(pattern: pattern, options: [])
            let matches = regex.matches(in: self.s, options: [], range: NSMakeRange(0, self.s.characters.count))
            
            for m in matches {
                
                let range = m.range
                let frame = self.frameOfTextInRange(range: range, inTextView: self.textView)
                let label = UILabel(frame: frame)
                label.text = ""
                label.font = UIFont(name: "Georgia-Italic", size: 17)
                label.textAlignment = .center
                label.textColor = UIColor(red: 40/255, green: 53/255, blue: 147/255, alpha: 1)
                self.l.append(label)
                
            }
            
            for i in 0..<self.result.count {
                
                self.textView.addSubview(self.l[i])
            }
            
            for i in 0..<l.count {
                
                l[i].text = clone_l[i].text
            }

        }
        
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            textView.frame = CGRect(x: 10, y: yValue, width: view.frame.width - 20, height: view.frame.height - (yValue+60))
            
            clone_l = l

            for i in 0..<l.count {
                
                l[i].removeFromSuperview()
            }
            
            l.removeAll()

            
            let pattern = "__________"
            let regex = try! NSRegularExpression(pattern: pattern, options: [])
            let matches = regex.matches(in: self.s, options: [], range: NSMakeRange(0, self.s.characters.count))
            
            
            for m in matches {
                
                let range = m.range
                let frame = self.frameOfTextInRange(range: range, inTextView: self.textView)
                
                let label = UILabel(frame: frame)
                label.text = ""
                label.font = UIFont(name: "Georgia-Italic", size: 17)
                label.textAlignment = .center
                label.textColor = UIColor(red: 40/255, green: 53/255, blue: 147/255, alpha: 1)
                
                self.l.append(label)
                
            }
            
            for i in 0..<self.result.count {
                
                self.textView.addSubview(self.l[i])
                
            }
            
            for i in 0..<l.count {
                
                l[i].text = clone_l[i].text
            }

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setUpViews()
        
        KVLoading.enableDimBackground()

        KVLoading.show()
        
        generateRandomTitleAndSendRequest()
        
    }
    
    func generateRandomTitleAndSendRequest(){
        
//        print(titlesArray)
    
         var randomNumber = random(min: 0, titlesArray.count-1)
        
         let title = titlesArray[randomNumber]
        
        sendServerRequest(articleTitle: title)
        
    }
    
    func sendServerRequest(articleTitle: String){
        
        print("\(articleTitle) \n")
    
      Alamofire.request("https://en.wikipedia.org/w/api.php?action=query&prop=extracts&explaintext=&%20titles=\(articleTitle)&format=json").responseJSON { response in
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                
                
                let json = JSON(data: data)
                
//                print(json)
                
                guard let extract = json["query"]["pages"].dictionary?.first?.value["extract"] else { self.generateRandomTitleAndSendRequest()
                    return}
                
                KVLoading.hide()

                self.test = String("\(extract)".characters.filter { !"\n\t\r====[]()<>".characters.contains($0) })
                
                self.s = self.test
                
                var r = [Range<String.Index>]()
                let t = self.s.linguisticTags(
                    in: self.s.startIndex..<self.s.endIndex,
                    scheme: NSLinguisticTagSchemeLexicalClass,
                    tokenRanges: &r)
                let ixs = t.enumerated().filter {
                    $0.1 == "SentenceTerminator"
                    }.map {r[$0.0].lowerBound}
                var prev = self.s.startIndex
                for ix in ixs {
                    let r = prev...ix
                    self.result.append(
                        self.s[r].trimmingCharacters(
                            in: NSCharacterSet.whitespaces))
                    prev = self.s.index(after: ix)
                }
                
                print("\(self.result.count)")
                
                
                
                
                if self.result.count < 15 {
                
                   self.generateRandomTitleAndSendRequest()
                                        
                    return
                
                }
                
                self.result.removeSubrange(10...self.result.count-1)
                
                if ViewController.level == "easy" {
                    
                    self.easy()
                }
                    
                else if ViewController.level == "medium" {
                    
                    self.medium()
                }
                    
                else {
                    
                    self.hard()
                }
                
                self.jumbledAnswersArray = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: self.correctAnswerArray) as! [String]
                
                let mystring = self.s
                var range = mystring.ranges(of: "__________")
                
                for i in 0..<self.result.count {
                    
                    self.startPos.append(mystring.characters.distance(from: mystring.characters.startIndex, to: range[i].lowerBound))
                    
                    self.endPos.append(mystring.characters.distance(from: mystring.characters.startIndex, to: range[i].upperBound) - 1)
                    
                }
                
                let textToAttribute = self.s
                let textToAttributeArray = textToAttribute.components(separatedBy: " ")
                let attributedText = NSMutableAttributedString()
                
                for word in textToAttributeArray{
                    
                    let myAttribute = [ NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 20.0)!]
                    let attributePending = NSMutableAttributedString(string: word + " ", attributes: myAttribute)
                    let myRange = NSRange(location: 0, length: word.characters.count)
                    let myCustomAttribute = [ "Tapped Word:": word]
                    attributePending.addAttributes(myCustomAttribute, range: myRange)
                    attributedText.append(attributePending)
                    
                }
                
                self.textView.attributedText = attributedText // Add your attributed text to textview.
                
                
                let pattern = "__________"
                let regex = try! NSRegularExpression(pattern: pattern, options: [])
                let matches = regex.matches(in: self.s, options: [], range: NSMakeRange(0, self.s.characters.count))
                
                
                for m in matches {
                    
                    let range = m.range
                    let frame = self.frameOfTextInRange(range: range, inTextView: self.textView)
                    
                    let label = UILabel(frame: frame)
                    label.text = ""
                    label.font = UIFont(name: "Georgia-Italic", size: 17)
                    label.textAlignment = .center
                    label.textColor = UIColor(red: 40/255, green: 53/255, blue: 147/255, alpha: 1)
                    
                    self.l.append(label)
                    
                }
                
                for i in 0..<self.result.count {
                    
                    self.textView.addSubview(self.l[i])
                    
                }
                
                self.tap = UITapGestureRecognizer(target: self, action: #selector(self.HandleTap(sender:)))
                self.tap?.delegate = self
                self.textView.addGestureRecognizer(self.tap!) // add gesture recognizer to text view.
                
            }
        }
        
    }
    
    func easy(){
    
        s = ""
        
        for i in 0..<result.count {
            
             generateRandomEasy(i: i)
            
        }

        
    }
    
    func medium(){
    
        s = ""
        
        for i in 0..<result.count {
            
            generateRandomMedium(i: i)
            
        }
        
    }
    
    func hard(){
    
        s = ""
        
        for i in 0..<result.count {
            
            generateRandomHard(i: i)
            
        }
        
    }
    
    
    func generateRandomEasy(i: Int){
    
        
        var wordArr = result[i].components(separatedBy: " ")
        
        var randomNumber = random(min: 0, wordArr.count-1)
        
        if wordArr[randomNumber].characters.count <= 2 || wordArr[randomNumber].characters.count <= 3 || wordArr[randomNumber].characters.count <= 10{
            
            correctAnswerArray.append(wordArr[randomNumber])
            
            wordArr[randomNumber] = "__________"
            
            result[i] = ""
            
            for j in 0..<wordArr.count {
                
                result[i].append(" \(wordArr[j])")
                
            }
            
            s.append(result[i])
            
        }
            
        else {
            
            generateRandomEasy(i: i)
            
        }
        
    }
    
    func generateRandomMedium(i: Int){
        
        var wordArr = result[i].components(separatedBy: " ")
        
        var randomNumber = random(min: 0, wordArr.count-1)
        
        if wordArr[randomNumber].characters.count <= 20 {
            
            correctAnswerArray.append(wordArr[randomNumber])
            
            wordArr[randomNumber] = "__________"
            
            result[i] = ""
            
            for j in 0..<wordArr.count {
                
                result[i].append(" \(wordArr[j])")
                
            }
            
            s.append(result[i])
            
        }
            
        else {
            
            generateRandomMedium(i: i)
            
        }
        
    }
    
    
    func generateRandomHard(i: Int){
        
        
        var wordArr = result[i].components(separatedBy: " ")
        var randomNumber = random(min: 0, wordArr.count-1)
       
        if wordArr[randomNumber].characters.count <= 10 && wordArr[randomNumber].characters.count >= 3{
        correctAnswerArray.append(wordArr[randomNumber])
        wordArr[randomNumber] = "__________"
        result[i] = ""
        
            for j in 0..<wordArr.count {
                result[i].append(" \(wordArr[j])")
            }
            
            s.append(result[i])
            
        }
        else {
            generateRandomHard(i: i)
        }
    }
    
    func setUpViews(){
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true

        let yValue = (navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height
        textView.frame = CGRect(x: 10, y: yValue, width: view.frame.width - 20, height: view.frame.height - (yValue+60))
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        submitButton.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        viewCorrectAnswers.addTarget(self, action: #selector(handleViewCorrectAnswers), for: .touchUpInside)
        newGameButton.addTarget(self, action: #selector(handleReplay), for: .touchUpInside)
        
        view.addSubview(backgroundImage)
        view.addSubview(textView)
        view.addSubview(submitButton)
        view.addSubview(viewCorrectAnswers)
        
        viewCorrectAnswers.isHidden = true
        
        navigationController?.navigationBar.addSubview(cancelButton)
        navigationController?.navigationBar.addSubview(newGameButton)
        navigationController?.navigationBar.addSubview(scoreLabel)
        
        
        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        submitButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        submitButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        viewCorrectAnswers.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        viewCorrectAnswers.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        viewCorrectAnswers.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        viewCorrectAnswers.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        cancelButton.centerYAnchor.constraint(equalTo: (navigationController?.navigationBar.centerYAnchor)!).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: (navigationController?.navigationBar.leftAnchor)!, constant: 15).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        newGameButton.centerYAnchor.constraint(equalTo: (navigationController?.navigationBar.centerYAnchor)!).isActive = true
        newGameButton.rightAnchor.constraint(equalTo: (navigationController?.navigationBar.rightAnchor)!, constant: -15).isActive = true
        newGameButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        newGameButton.heightAnchor.constraint(equalToConstant: 30).isActive = true

        
        scoreLabel.centerYAnchor.constraint(equalTo: (navigationController?.navigationBar.centerYAnchor)!).isActive = true
        scoreLabel.centerXAnchor.constraint(equalTo: (navigationController?.navigationBar.centerXAnchor)!).isActive = true
        scoreLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        scoreLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

    }
    
    func handleCancel(){
        
        UIApplication.shared.keyWindow?.rootViewController = HomeScreenVC()
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func handleSubmit(){
    
        for i in 0..<result.count {
        
            if l[i].text == correctAnswerArray[i] {

                rightWrongArray.append("right")
                score = score + 1
                l[i].textColor = UIColor(red: 46/255, green: 125/255, blue: 50/255, alpha: 1)
            }
            
            else{
                
                rightWrongArray.append("wrong")
                l[i].textColor = UIColor(red: 198/255, green: 40/255, blue: 40/255, alpha: 1)
            }
        }
        
        scoreLabel.text = "Score = \(score)/10"
        
        submitButton.isHidden = true
        viewCorrectAnswers.isHidden = false
        
        textView.removeGestureRecognizer(tap!)
        
        let alertController = UIAlertController(title: "Your Score is \(score)/10", message: "- Correct answers are shown in green \n- Incorrect answers are shown in red", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            (result : UIAlertAction) -> Void in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
        score = 0
    }
    
    func handleViewCorrectAnswers(){
    
        for i in 0..<result.count {
        
            l[i].text = correctAnswerArray[i]
            l[i].textColor = UIColor(red: 40/255, green: 53/255, blue: 147/255, alpha: 1)
        }
        
    }
    
    func handleReplay(){
        
        
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: ViewController())
        
        dismiss(animated: false, completion: nil)
    }
    
    func HandleTap(sender: UITapGestureRecognizer) {
        
        let myTextView = sender.view as! UITextView //sender is TextView
        let layoutManager = myTextView.layoutManager //Set layout manager
        
        // location of tap in myTextView coordinates
        
        var location = sender.location(in: myTextView)
        location.x -= myTextView.textContainerInset.left;
        location.y -= myTextView.textContainerInset.top;

        let characterIndex = layoutManager.characterIndex(for: location, in: myTextView.textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        if characterIndex < myTextView.textStorage.length {
            
            print("Your character is at index: \(characterIndex)") //optional character index.
            
            let myRange = NSRange(location: characterIndex, length: 1)
            let substring = (myTextView.attributedText.string as NSString).substring(with: myRange)
            print("character at index: \(substring)")
            
            let attributeName = "Tapped Word:" //make sure this matches the name in viewDidLoad()
            let attributeValue = myTextView.attributedText.attribute(attributeName, at: characterIndex, effectiveRange: nil) as? String
            if let value = attributeValue {
                print("You tapped on \(attributeName) and the value is: \(value)")
                
                if value == "__________" {
                
                    print("blank touched")
                    
                    handleBlankClick(characterIndex: characterIndex, location: location)
                    
                }
                
            }
            
        }
    }
    
    func random(min: Int, _ max: Int) -> Int {
        guard min < max else {return min}
        return Int(arc4random_uniform(UInt32(1 + max - min))) + min
        
    }
    

    func frameOfTextInRange(range:NSRange, inTextView textView:UITextView) -> CGRect {
        let beginning = textView.beginningOfDocument
        
        let start = textView.position(from: beginning, offset: range.location)!
        
        let end = textView.position(from: start
            , offset: range.length)!
        
        let textRange = textView.textRange(from: start, to: end)!
        
        let rect = textView.firstRect(for: textRange)
        return textView.convert(rect, from: textView)
    }
    
    
    func handleBlankClick(characterIndex: Int, location: CGPoint) {
        
        let data = [jumbledAnswersArray]
        showGroupPicker(title: "Pick a word", groupData: data, selectedItems: [jumbledAnswersArray[5]], onDone: { [unowned self] (indices, items) in
            
            print("chosen Answer: ", items[0])
            
            switch characterIndex {
            
                case self.startPos[0]...self.endPos[0]:
                   self.l[0].text = items[0]
                
                case self.startPos[1]...self.endPos[1]:
                
                    self.l[1].text = items[0]

                case self.startPos[2]...self.endPos[2]:
                    
                    self.l[2].text = items[0]

                case self.startPos[3]...self.endPos[3]:
                
                    self.l[3].text = items[0]
                
                case self.startPos[4]...self.endPos[4]:
                    
                    self.l[4].text = items[0]

                case self.startPos[5]...self.endPos[5]:
                    
                    self.l[5].text = items[0]

                case self.startPos[6]...self.endPos[6]:
                
                    self.l[6].text = items[0]

                case self.startPos[7]...self.endPos[7]:
                    
                    self.l[7].text = items[0]

                case self.startPos[8]...self.endPos[8]:
                
                    self.l[8].text = items[0]

                case self.startPos[9]...self.endPos[9]:
                
                    self.l[9].text = items[0]

                default:
            
                  print("default")
            }

            }, onCancel: {
                
        })
    }

}






