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
    var users: [User]?
    
    @IBOutlet weak var yeahButton: UIButton!
    @IBOutlet weak var nahButton: UIButton!
    struct Card {
        let cardView: CardView
        let swipeView: SwipeView
        let user:User
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.titleView = UIImageView(image: UIImage(named: "nav-header"))
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav-back-button"), style: UIBarButtonItemStyle.Plain, target: self, action: "goToProfile:")
        navigationItem.setLeftBarButtonItem(leftBarButtonItem, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardStackView.backgroundColor = UIColor.clearColor()
        
        nahButton.setImage(UIImage(named: "nah-button-pressed"), forState: UIControlState.Highlighted)
        yeahButton.setImage(UIImage(named: "yeah-button-pressed"), forState: UIControlState.Highlighted)

//        backCard = createCard(backCardTopMargin)
//        cardStackView.addSubview(backCard!.swipeView)
//        
//        frontCard = createCard(frontCardTopMargin)
//        cardStackView.addSubview(frontCard!.swipeView)
        
        fetchUnviewedUsers({
            users in
            self.users = users
            println(self.users)
            
            if let card = self.popCard() {
                self.frontCard = card
                self.cardStackView.addSubview(self.frontCard!.swipeView)
            }
            
            if let card = self.popCard() {
                self.backCard = card
                self.backCard!.swipeView.frame = self.createCardFrame(self.backCardTopMargin)
                self.cardStackView.insertSubview(self.backCard!.swipeView, belowSubview: self.frontCard!.swipeView)
            }
            
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func yeahButtonPressed(sender: UIButton) {
        if let card = frontCard {
            card.swipeView.swipe(SwipeView.Direction.Right)
        }
    }
    
    @IBAction func nahButtonPressed(sender: UIButton) {
        if let card = frontCard {
            card.swipeView.swipe(SwipeView.Direction.Left)
        }
    }
    
    private func createCardFrame(topMargin: CGFloat)->CGRect{
        return CGRect(x: 0, y: topMargin, width: cardStackView.frame.width, height: cardStackView.frame.height)
    }
    
    private func createCard(user: User) -> Card {
        
        
        let cardView = CardView()
        cardView.name = user.name
        user.getPhoto({
            image in
            cardView.image = image
        })
        
        
        
        let swipeView = SwipeView(frame: createCardFrame(0))
        swipeView.delegate = self
        swipeView.innerView = cardView
        return Card(cardView: cardView, swipeView: swipeView, user: user)
    }
    
    private func popCard() -> Card? {
        if users != nil && users?.count > 0 {
            return createCard(users!.removeLast())
        }
        return nil
    }

    private func switchCards() {
        if let card = backCard {
            frontCard = card
            UIView.animateWithDuration(0.2, animations: {
                self.frontCard!.swipeView.frame = self.createCardFrame(self.frontCardTopMargin)
            })
        }
        if let card = self.popCard() {
            self.backCard = card
            self.backCard!.swipeView.frame = self.createCardFrame(self.backCardTopMargin)
            self.cardStackView.insertSubview(self.backCard!.swipeView, belowSubview: self.frontCard!.swipeView)
        }
    }
    
    //MARK:  function for leftbarbuttonitem
    func goToProfile(button: UIBarButtonItem) {
        
        pageController.goToPreviousVC()

    }
    
    //MARK:  SwipeViewDelegate
    
    func swipedLeft() {
        println("left")
        if let frontCard = frontCard {
            frontCard.swipeView.removeFromSuperview()
            saveSkip(frontCard.user)
            switchCards()
        }
    }
    
    func swipedRight() {
        println("right")
        if let frontCard = frontCard {
            frontCard.swipeView.removeFromSuperview()
            saveLike(frontCard.user)
            switchCards()
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