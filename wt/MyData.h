//
//  MyData.h
//  wt
//
//  Created by MUKBC on 2014/09/03.
//  Copyright (c) 2014年 Hiroki Nomura. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MyData : NSManagedObject

@property (nonatomic, retain) NSString * myNumber;
@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSString * postTime;
@property (nonatomic, retain) NSString * sendPostTime;

@end
