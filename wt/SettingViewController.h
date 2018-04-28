//
//  SettingViewController.h
//  wt
//
//  Created by MUKBC on 2014/09/02.
//  Copyright (c) 2014年 Hiroki Nomura. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController {
    
}
@property (strong, nonatomic) IBOutlet UILabel *MyID;
@property (strong, nonatomic) IBOutlet UITextField *PersonsName;
@property (strong, nonatomic) IBOutlet UITextField *PersonsNumber;

@property (strong, nonatomic) IBOutlet UIButton *addbutton;



- (IBAction)backbutton:(id)sender;
- (IBAction)deleatbutton:(id)sender;
- (IBAction)AddPersonsData:(id)sender;



@end
