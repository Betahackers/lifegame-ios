//
//  ViewController.swift
//  lifegame
//
//  Created by Marek on 18/02/2017.
//  Copyright © 2017 Marek Pivovarnik. All rights reserved.
//

import UIKit
import Koloda

class LifegameViewController: UIViewController, KolodaViewDataSource, KolodaViewDelegate {

    // MARK: - Outlets
    
    @IBOutlet weak var yearOfLifeLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var kolodaView: KolodaView! {
        didSet {
            kolodaView.dataSource = self
            kolodaView.delegate = self
        }
    }
    
    @IBOutlet weak var prop1IndicatorView: UIView!
    @IBOutlet weak var prop2IndicatorView: UIView!
    @IBOutlet weak var prop3IndicatorView: UIView!
    @IBOutlet weak var prop4IndicatorView: UIView!
    
    // MARK: - Properties
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // life properties
    
    var loveScore = Constant.defaultScore {
        didSet {
            if Double(loveScore) > Constant.maximumScore {
                showGameOverScreen(withCauseOfDeath: .tooMuchLove)
            } else if Double(loveScore) < Constant.minimumScore {
                showGameOverScreen(withCauseOfDeath: .tooLessLove)
            } else {
                prop1IndicatorView.frame = determinePropIndicatorViewFrame(withScore: loveScore, forView: prop1IndicatorView)
            }
        }
    }
    var funScore = Constant.defaultScore {
        didSet {
            if Double(funScore) > Constant.maximumScore {
                showGameOverScreen(withCauseOfDeath: .tooMuchFun)
            } else if Double(funScore) < Constant.minimumScore {
                showGameOverScreen(withCauseOfDeath: .tooLessFun)
            } else {
                prop2IndicatorView.frame = determinePropIndicatorViewFrame(withScore: funScore, forView: prop2IndicatorView)
            }
        }
    }
    var healthScore = Constant.defaultScore {
        didSet {
            if Double(healthScore) > Constant.maximumScore {
                showGameOverScreen(withCauseOfDeath: .tooMuchHealth)
            } else if Double(healthScore) < Constant.minimumScore {
                showGameOverScreen(withCauseOfDeath: .tooLessHealth)
            } else {
                prop3IndicatorView.frame = determinePropIndicatorViewFrame(withScore: healthScore, forView: prop3IndicatorView)
            }
        }
    }
    var moneyScore = Constant.defaultScore {
        didSet {
            if Double(moneyScore) > Constant.maximumScore {
                showGameOverScreen(withCauseOfDeath: .tooMuchMoney)
            } else if Double(healthScore) < Constant.minimumScore {
                showGameOverScreen(withCauseOfDeath: .tooLessMoney)
            } else {
                prop4IndicatorView.frame = determinePropIndicatorViewFrame(withScore: moneyScore, forView: prop4IndicatorView)
            }
        }
    }
    
    var yearOfLife = 15 {
        didSet {
            yearOfLifeLabel.text = "\(yearOfLife)"
        }
    }
    
    // Managers
    
    private let dataManger = DataManager.shared
    
    // Model
    
    var deckOfCards = [RLMCard]()
    var deckOfCardViews = [CardView]()
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        dataManger.loadDeck { [weak self] (cardDeck) in
            for index in (0..<cardDeck.count) {
                self?.deckOfCards.append(cardDeck[index])
                if let cardView = Bundle.main.loadNibNamed("CardView", owner: self, options: nil)?.first as? CardView {
                    
                    print("\(cardDeck[index].person)")
                    
                    let personServerName = cardDeck[index].person
                    var personLocalName = personServerName
                    if (personServerName == "parents") {
                        let random = Int(arc4random_uniform(2))
                        if (random == 0) {
                            personLocalName = "mum"
                        } else {
                            personLocalName = "dad"
                        }
                    }
                    if (personServerName == "kid") {
                        let random = Int(arc4random_uniform(2))
                        if (random == 0) {
                            personLocalName = "kidBoy"
                        } else {
                            personLocalName = "kidGirl"
                        }
                    }
                    if (personServerName == "ex") {
                        let random = Int(arc4random_uniform(2))
                        if (random == 0) {
                            personLocalName = "loverMan"
                        } else {
                            personLocalName = "loverWoman"
                        }
                    }
                    if (personServerName == "sex friends") {
                        let random = Int(arc4random_uniform(2))
                        if (random == 0) {
                            personLocalName = "loverMan"
                        } else {
                            personLocalName = "loverWoman"
                        }
                    }
                    if (personServerName == "lover") {
                        let random = Int(arc4random_uniform(2))
                        if (random == 0) {
                            personLocalName = "loverMan"
                        } else {
                            personLocalName = "loverWoman"
                        }
                    }
                    if (personServerName == "friend") {
                        personLocalName = "colleague"
                    }
                    if (personServerName == "stranger") {
                        personLocalName = "colleague"
                    }
                    if (personServerName == "seller") {
                        personLocalName = "colleague"
                    }
                    if (personServerName == "smoky granny") {
                        personLocalName = "smoky granny"
                    }
                    
                    cardView.characterImageView.image = UIImage(named: personLocalName)
                    cardView.characterNameLabel.text = personLocalName.capitalized
                    
                    if cardDeck[index].answers.count == 2 {
                        cardView.leftAnswerLabel.text = cardDeck[index].answers[0].text
                        cardView.rightAnswerLabel.text = cardDeck[index].answers[1].text
                    }
                    
                    self?.deckOfCardViews.append(cardView)
                    self?.kolodaView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Koloda data source implementation
    
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return deckOfCardViews.count
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        questionLabel.text = deckOfCards[index].title
        return deckOfCardViews[index]
    }
    
    func koloda(_ koloda: KolodaView, allowedDirectionsForIndex index: Int) -> [SwipeResultDirection] {
        return [.bottomLeft, .bottomRight, .left, .right]
    }
    
    // MARK: - Koloda delegate imaplementation
    
    func koloda(_ koloda: KolodaView, draggedCardWithPercentage finishPercentage: CGFloat, in direction: SwipeResultDirection) {
        
        let card = deckOfCardViews[kolodaView.currentCardIndex]
        card.shaderView.alpha = CGFloat(Double(finishPercentage) / 100)
        
        switch direction {
        case .bottomLeft, .left:
            card.leftAnswerLabel.isHidden = false
            card.rightAnswerLabel.isHidden = true
        case .right, .bottomRight:
            card.leftAnswerLabel.isHidden = true
            card.rightAnswerLabel.isHidden = false
        default: break
        }
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        yearOfLife += 1
        
        var answer = RLMAnswer()
        
        if deckOfCards[index].answers.count == 2 {
            switch direction {
            case .bottomLeft, .left:
                answer = deckOfCards[index].answers[0]
            case .right, .bottomRight:
                answer = deckOfCards[index].answers[1]
            default: break
            }
        }
        
        funScore += answer.fun
        loveScore += answer.love
        healthScore += answer.health
        moneyScore += answer.money
        
        questionLabel.text = deckOfCards[index+1].title
        
    }
    
    func kolodaDidRunOutOfCards(koloda: KolodaView) {
//        dataSource.reset()
    }
    
    func kolodaDidResetCard(_ koloda: KolodaView) {
        let card = deckOfCardViews[kolodaView.currentCardIndex]
        card.shaderView.alpha = 0
    }
    
    // MARK: - Helper functions
    
    private func determinePropIndicatorViewHeight(withScore score: Int) -> CGFloat {
        return CGFloat(Double(score) * Constant.maximumViewHeight / Constant.maximumScore)
    }
    
    private func determinePropIndicatorViewFrame(withScore score: Int, forView view: UIView) -> CGRect {
        let scoreHeight = determinePropIndicatorViewHeight(withScore: score)
        return CGRect(
            x: CGFloat(Constant.maximumViewHeight) - scoreHeight,
//            x: view.frame.origin.x,
            y: view.bounds.origin.y,
            width: view.bounds.width,
            height: scoreHeight)
    }
    
    private func showGameOverScreen(withCauseOfDeath causeOfDeath: CauseOfDeath) {
        let gameOverStoryboard = UIStoryboard(name: "GameOver", bundle: nil)
        let gameOverViewController = gameOverStoryboard.instantiateViewController(withIdentifier: "GameOverViewController") as! GameOverViewController
        
        gameOverViewController.causeOfDeath = causeOfDeath
        gameOverViewController.makeRootViewControllerWithTransitionDuration(0.3)
    }
    
    // MARK: - Constants
    
    private struct Constant {
        static let maximumViewHeight: Double = 50
        
        static let maximumScore: Double = 100
        static let minimumScore: Double = 0
        static let defaultScore: Int = 50
    }
    
}

enum CauseOfDeath {
    case tooMuchLove
    case tooLessLove
    case tooMuchMoney
    case tooLessMoney
    case tooMuchHealth
    case tooLessHealth
    case tooMuchFun
    case tooLessFun
    case tooOld
}

