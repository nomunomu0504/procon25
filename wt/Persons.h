//
//  Persons.h
//  wt
//
//  Created by MUKBC on 2014/09/02.
//  Copyright (c) 2014年 Hiroki Nomura. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Persons : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * number;
@property (nonatomic, retain) NSString * myName;
@property (nonatomic, retain) NSString * myNumber;

@end
