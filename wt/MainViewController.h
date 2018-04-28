//
//  MainViewController.h
//  wt
//
//  Created by MUKBC on 2014/08/31.
//  Copyright (c) 2014年 Hiroki Nomura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import "Reachability.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <CoreData/CoreData.h>
#import "Persons.h"
#import "EditData.h"
#import "AddressViewController.h"

@interface MainViewController : UIViewController<GKSessionDelegate, UITextFieldDelegate, UINavigationBarDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate > {

}

@property ( strong, nonatomic ) IBOutlet UITableView *infotableview;


@property ( nonatomic, strong ) NSURL *url;
@property ( nonatomic, strong ) NSData *senddata;
@property ( nonatomic, strong ) NSString *NameString;
@property ( nonatomic, strong ) NSString *PhoneNumberString;
@property ( nonatomic, strong ) NSString *NowString;
@property ( nonatomic, strong ) NSString *ownpeerID;
@property ( nonatomic, strong ) NSMutableArray *receiveDatas;
@property ( nonatomic, strong ) NSMutableData *receivedData;
@property ( nonatomic, strong ) GKSession *Mysession;
@property ( nonatomic, copy ) NSMutableArray *sendData;
@property ( nonatomic, strong ) NSMutableArray *getdatas;
@property ( nonatomic, strong ) NSMutableArray *Allgetdatas;
@property ( nonatomic, strong ) NSMutableArray *Namegetdatas;

@property ( nonatomic, strong ) Reachability *curReach;
@property ( nonatomic ) NetworkStatus netStatus;
@property ( nonatomic ) int alerttag;

@property ( nonatomic ) BOOL sessionflag;
@property ( nonatomic ) BOOL initflag;
@property ( nonatomic ) BOOL sendinternetflag;
@property ( nonatomic, strong ) NSString *sendformat;
- ( void )startsession;


@end
