//
//  AddressViewController.h
//  wt
//
//  Created by MUKBC on 2014/08/31.
//  Copyright (c) 2014年 Hiroki Nomura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>
#import "MainViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "EditData.h"


@interface AddressViewController : UIViewController<ABPeoplePickerNavigationControllerDelegate, ABPersonViewControllerDelegate, UITableViewDataSource, UITableViewDelegate> {
    
}

@property ( strong, nonatomic ) IBOutlet UITableView *addressTable;
@property ( strong, nonatomic ) IBOutlet NSData *arrayData;
@property ( strong, nonatomic ) IBOutlet NSMutableArray *tableviewpersons; //テーブルの表示に使用する
@property ( strong, nonatomic ) NSString *firstName;
@property ( strong, nonatomic ) NSString *lastName;
@property ( strong, nonatomic ) NSString *PhoneNumber;
@property ( nonatomic ) BOOL isEditing; //編集モード中であるか

@end
