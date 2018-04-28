//
//  PostMessageViewController.h
//  wt
//
//  Created by MUKBC on 2014/09/02.
//  Copyright (c) 2014年 Hiroki Nomura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface PostMessageViewController : UIViewController<UITextFieldDelegate, GKSessionDelegate> {
    
}

@property (strong, nonatomic) IBOutlet UITextView *NowInfoText;
@property ( nonatomic, strong ) NSString *ownpeerID;
@property ( nonatomic, strong ) GKSession *Mysession;
@property ( nonatomic, strong ) NSMutableArray *arrdatas;
@property ( nonatomic ) BOOL flag;

- (IBAction)SendButton:(id)sender;

@end
