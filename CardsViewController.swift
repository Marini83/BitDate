//
//  CardsViewController.swift
//  BitDate
//
//  Created by User  on 2015-08-26.
//  Copyright (c) 2015 Wub.com. All rights reserved.
//
//
import UIKit

class CardsViewController: UIViewController, SwipeViewDelegate {

    let frontCardTopMargin: CGFloat = 0
    let backCardTopMargin: CGFloat = 10
    @IBOutlet weak var cardStackView: UIView!
    
    var backCard: Card?
    var frontCard: Card?
    
    struct Card {
        let cardView: CardView
        let swipeView: SwipeView
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardStackView.backgroundColor = UIColor.clearColor()
        
        backCard = createCard(backCardTopMargin)
        cardStackView.addSubview(backCard!.swipeView)
        
        frontCard = createCard(frontCardTopMargin)
        cardStackView.addSubview(frontCard!.swipeView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private func createCardFrame(topMargin: CGFloat)->CGRect{
        return CGRect(x: 0, y: topMargin, width: cardStackView.frame.width, height: cardStackView.frame.height)
    }
    
    private func createCard(topMargin: CGFloat) -> Card {
        let cardView = CardView()
        let swipeView = SwipeView(frame: createCardFrame(topMargin))
        swipeView.delegate = self
        swipeView.innerView = cardView
        return Card(cardView: cardView, swipeView: swipeView)
    }
    
    //MARK:  SwipeViewDelegate
    
    func swipedLeft() {
        println("left")
        if let frontCard = frontCard {
            frontCard.swipeView.removeFromSuperview()        }
    }
    
    func swipedRight() {
        println("right")
        if let frontCard = frontCard {
            frontCard.swipeView.removeFromSuperview()

        }
    }

}

//import UIKit
//class CardsViewController: UIViewController{
//    
//    let frontCardTopMargin: CGFloat = 0
//    let backCardTopMargin: CGFloat = 10
//    
//    @IBOutlet weak var cardStackView: UIView!
//    
//    var backCard: SwipeView?
//    var frontCard: SwipeView?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        backCard = SwipeView(frame: createCardFrame(backCardTopMargin))
//        cardStackView.addSubview(backCard!)
//        
//        frontCard = SwipeView(frame: createCardFrame(frontCardTopMargin))
//        cardStackView.addSubview(frontCard!)
//        
//    }
//    
//    private func createCardFrame(topMargin: CGFloat)->CGRect{
//        return CGRect(x: 0, y: topMargin, width: cardStackView.frame.width, height: cardStackView.frame.height)
//    }
//}