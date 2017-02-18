//
//  ViewController.swift
//  lifegame
//
//  Created by Marek on 18/02/2017.
//  Copyright © 2017 Marek Pivovarnik. All rights reserved.
//

import UIKit
import Koloda

class LifeGameViewController: UIViewController, KolodaViewDataSource, KolodaViewDelegate {

    // MARK: - Outlets
    
    var prop1 = 0
    var prop2 = 0
    var prop3 = 0
    var prop4 = 0
    
    @IBOutlet weak var kolodaView: KolodaView!
    
    // MARK: - Properties
    
    private let dataManger = DataManager.shared
    
    var deckOfCards = [Card]()
    
    var deckOfCardViews = [CardView]()
    
    func fetchCards(completionHandler: @escaping (Bool) -> Void) {
        completionHandler(true)
    }
    
    
    func loadDeck() {
//        for card in deckOfCards {
//            let views = Bundle.main.loadNibNamed("CardView", owner: self, options: nil)
//            if let cardView = views?.first as? CardView {
//                cardView.cardImageView.image = UIImage() // CardImage
//                let colorIndex = Int(arc4random_uniform(6))
////                cardView.cardImageView.backgroundColor = randomColors[colorIndex]
////                cardView.questionLabel.text = card.question
//                
////                
//        cardView.addGestureRecognizer(swipeRight)
//
//                view.addSubview(cardView)
//            }
//        }
    }
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
//        dataManger.saveDeckOfCards { [weak self] (cards) in
//            if let deck = cards {
//                self?.deckOfCards = deck
//                self?.kolodaView.reloadData()
//                self?.loadDeck()
//            }
//        }
        for index in (0..<10) {
            if let cardView = Bundle.main.loadNibNamed("CardView", owner: self, options: nil)?.first as? CardView {
                cardView.shaderView.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 1)
                cardView.sharedLabel.text = "\(index)"
//                let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan(_:)))
//                cardView.addGestureRecognizer(gestureRecognizer)
                deckOfCardViews.append(cardView)
            }
            
        }
        kolodaView.dataSource = self
        kolodaView.delegate = self
    }
    
    func pan(_ gesture: UITapGestureRecognizer) {
        switch  gesture.state {
        case .began:
            print("BEGAN!!!")
        case .ended:
            print("ENDED!!!")
        default:
            break
        }
    }
    
    // MARK: - Koloda data source implementation
    
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return deckOfCardViews.count
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView { 
        return deckOfCardViews[index]
//        if let cardView = Bundle.main.loadNibNamed("CardView", owner: self, options: nil)?.first as? CardView {
//            cardView.shaderView.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 1)
//            cardView.sharedLabel.text = "text"
//        }
//        return UIImageView(image: UIImage(named: "BetaChallengeTestImage"), highlightedImage: nil)
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
            card.sharedLabel.text = "LEFT"
        case .right, .bottomRight:
            card.sharedLabel.text = "RIGHT"
        default: break
        }
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        print("CARD RESET")
    }
    
    func kolodaDidResetCard() {
        print("CARD RESET")
    }
    
    func kolodaDidRunOutOfCards(koloda: KolodaView) {
//        dataSource.reset()
    }
    
    func koloda(koloda: KolodaView, didSelectCardAt index: Int) {
        
    }
    
    
//    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
//        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
//            switch swipeGesture.direction {
//            case UISwipeGestureRecognizerDirection.right:
//                gesture.view?.removeFromSuperview()
//                print("Swiped right")
//            case UISwipeGestureRecognizerDirection.left:
//                gesture.view?.removeFromSuperview()
//                print("Swiped left")
//            default: break
//            }
//        }
//    }
    
}

