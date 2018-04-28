//
//  CustomTableViewCell.h
//  wt
//
//  Created by MUKBC on 2014/10/04.
//  Copyright (c) 2014年 Hiroki Nomura. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *NameLabel;
@property (strong, nonatomic) IBOutlet UILabel *MessageLabel;
@property (strong, nonatomic) IBOutlet UIView *content;
@property (strong, nonatomic) IBOutlet UILabel *DateLabel;


+ (CGFloat)rowHeight;

@end
