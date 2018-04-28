//
//  CustomTableViewCell.m
//  wt
//
//  Created by MUKBC on 2014/10/04.
//  Copyright (c) 2014年 Hiroki Nomura. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

@synthesize NameLabel, MessageLabel;

- (void)awakeFromNib {
    
    self.NameLabel.text = NSStringFromClass([self class]);
    self.MessageLabel.text = NSStringFromClass([self class]);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)rowHeight {
    
    return 60.0f;
}

@end
