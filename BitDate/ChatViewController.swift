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
    
    
    var messageListener: MessageListener?
    var matchID: String?
    var senderAvatar: UIImage!
    var recipientAvatar: UIImage!
    var recipient: User!
    var messages: [JSQMessage] = []
    //var recipientId = ""
    let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleBlueColor())
    let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleGreenColor())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //comment the following lines if avatars work
//        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero
//        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero
//        self.senderId = currentUser()!.id
//        self.senderDisplayName = currentUser()!.name
       // println(currentUser()!.id)
        if let id = matchID {
            fetchMessages(id, {
                messages in
                for m in messages {
                    self.messages.append(JSQMessage(senderId: m.senderID, senderDisplayName: m.senderID, date: m.date, text: m.message))
                }
                self.finishReceivingMessage()
            })
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        if let id = matchID {
            messageListener = MessageListener(matchID: id, startDate: NSDate(), callback: {
                message in
                self.messages.append(JSQMessage(senderId: message.senderID, senderDisplayName: message.senderID, date: message.date, text: message.message))
                self.finishReceivingMessage()
            })
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        messageListener?.stop()
    }
    
    override var senderId: String! {
        get {
            return currentUser()!.id
        }
        
        set {
            super.senderId = newValue
        }
    }
    
    override var senderDisplayName: String! {
        get {
            return currentUser()!.name
        }
        
        set {
            super.senderDisplayName = newValue
        }
    }

    
    
//    @objc(sendersDisplayName)
//      func senderDisplayName() -> String! {
//        return currentUser()!.id
//    }
//    @objc(sendersID)
//      func senderId() -> String! {
//        return currentUser()!.id
//    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
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
    //navigationItem.rightBarButtonItem?.image = UIImage(named: "myNewButton")
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
//        var localSenderId = senderId
//        var localRecipientId = self.recipientId
//        if (self.messages.count % 2 == 1)
//        {
//            localSenderId = self.recipientId
//            localRecipientId = senderId
//        }
        
        let m = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
        //let m = JSQMessage(senderId: localSenderId, senderDisplayName: senderDisplayName, date: date, text: text)
        
       // self.messages.append(m)
        if let id = matchID {
            saveMessage(id, Message(message: text, senderID: senderId, date: date))
        }
        finishSendingMessage()
        
        
    }
    
    //get avatar
    func updateAvatarImageForIndexPath( indexPath: NSIndexPath, avatarImage: UIImage) {
        let cell: JSQMessagesCollectionViewCell = self.collectionView.cellForItemAtIndexPath(indexPath) as! JSQMessagesCollectionViewCell
        cell.avatarImageView.image = JSQMessagesAvatarImageFactory.circularAvatarImage( avatarImage, withDiameter: 60 )
    }
    
    func updateAvatarForUser( indexPath: NSIndexPath, user: User ) {
        user.getPhoto({ (image) -> () in
            self.updateAvatarImageForIndexPath( indexPath, avatarImage: image)
        })
    }
    
//    func updateAvatarForRecipient( indexPath: NSIndexPath, user: User ) {
//        user.getPhoto({ (image) -> () in
//            self.recipientAvatar = image
//            self.updateAvatarImageForIndexPath( indexPath, avatarImage: image)
//        })
//    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        var imgAvatar = JSQMessagesAvatarImage.avatarWithImage( JSQMessagesAvatarImageFactory.circularAvatarImage( UIImage(named: "profile-header"), withDiameter: 60 ) )
        if (self.messages[indexPath.row].senderId == self.senderId)
        {
            if (self.senderAvatar != nil)
            {
                imgAvatar = JSQMessagesAvatarImage.avatarWithImage( JSQMessagesAvatarImageFactory.circularAvatarImage( self.senderAvatar, withDiameter: 60 ) )
            }
            else
            {
                currentUser()!.getPhoto({ (image) -> () in
                    self.senderAvatar = image
                    self.updateAvatarImageForIndexPath( indexPath, avatarImage: image)
                })
            }
        }
        else
        {
            if (self.recipientAvatar != nil)
            {
                imgAvatar = JSQMessagesAvatarImage.avatarWithImage( JSQMessagesAvatarImageFactory.circularAvatarImage( self.recipientAvatar, withDiameter: 60 ) )
            }
            else
            {
//                getUserAsync( self.messages[indexPath.row].senderId, { (user) -> () in
//                    self.updateAvatarForRecipient( indexPath, user: user ) } )
                self.recipient.getPhoto({ (image) -> () in
                    self.updateAvatarImageForIndexPath( indexPath, avatarImage: image)
                })
            }
        }
        return imgAvatar
    }
    
   
    
}