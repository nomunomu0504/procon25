//
//  EditData.h
//  wt
//
//  Created by MUKBC on 2014/08/28.
//  Copyright (c) 2014年 Hiroki Nomura. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define MODEL_NAME @"Persons"
#define DB_NAME @"Persons.sqlite"
#define ENTITY_NAME @"Persons"

@interface EditData : NSObject

- ( void )SavePersonsData:( NSDictionary * )datas;
- ( NSMutableArray * )LoadPersonsData;
- ( void )DeletePersonsData:(NSString *)PersonsName;

- ( void )SaveMyData:( NSString * )Number;
- ( NSMutableArray * )LoadMyData;

- ( void )SaveMymessage:( NSString * )message;
- ( NSMutableArray * )LoadMymessage;

- ( void )SaveGetdatas:( NSMutableArray * )getdatas;
- ( NSMutableArray * )LoadGetdatas;

- ( void )DeleteMymessage;
- ( void )DeleteGetdatas;

- ( void )DeleteAllGetdatas;
- ( NSMutableArray * )LoadAllGetdatas;
- ( void )SaveAllGetdatas:( NSMutableArray * )allgetdatas;


@end
