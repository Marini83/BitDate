//
//  ChatViewController.swift
//  BitDate
//
//  Created by User  on 2015-09-09.
//  Copyright (c) 2015 Wub.com. All rights reserved.
//

import Foundation
//import JSQMessagesViewController

class ChatViewController: JSQMessagesViewController {
    
    var messages: [JSQMessage] = []
    let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleBlueColor())
    let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleLightGrayColor())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //remove the following lines if avatars work 
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero
    }
    
//    override var senderId: String! {
//        get {
//            return currentUser()!.id
//        }
//        
//        set {
//            super.senderId = newValue
//        }
//    }
//    
//    override var senderDisplayName: String! {
//        get {
//            return currentUser()!.name
//        }
//        
//        set {
//            super.senderDisplayName = newValue
//        }
//    }
    
    @objc(sendersDisplayName)
      func senderDisplayName() -> String! {
        return currentUser()!.id
    }
    @objc(sendersID)
      func senderId() -> String! {
        return currentUser()!.id
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        var data = self.messages[indexPath.row]
        return data
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        var data = self.messages[indexPath.row]
        if data.senderId == PFUser.currentUser()!.objectId {
            return outgoingBubble
        }
        else {
            return incomingBubble
        }
    }
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        let m = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
        self.messages.append(m)
        finishSendingMessage()
    }
}