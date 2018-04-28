//
//  FirstViewController.h
//  wt
//
//  Created by MUKBC on 2014/08/31.
//  Copyright (c) 2014年 Hiroki Nomura. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController {
    
}
@property (strong, nonatomic) IBOutlet UILabel *title_label;
@property (strong, nonatomic) IBOutlet UILabel *explanation_label;
@property (strong, nonatomic) IBOutlet UIButton *Button;
@property (strong, nonatomic) NSMutableArray *MyData;
@property (strong, nonatomic) NSString *UUID;
@property (strong, nonatomic) NSArray *uuid;

@property (strong, nonatomic) IBOutlet UIButton *startbutton;


- ( IBAction )clicked:(id)sender;



@end
