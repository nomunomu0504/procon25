//
//  EditData.m
//  wt
//
//  Created by MUKBC on 2014/08/28.
//  Copyright (c) 2014年 Hiroki Nomura. All rights reserved.
//

#import "EditData.h"
#import "AppDelegate.h"
#import "Persons.h"
#import "MyData.h"
#import "GetDatas.h"

@implementation EditData

////////////////////////////////////////////////////////////////////////////////

- ( void )SavePersonsData:( NSDictionary * )datas {
    
    AppDelegate *delegate = ( AppDelegate * )[ [ UIApplication sharedApplication ] delegate ];
    
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    Persons *p = [ NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass( [ Persons class ] ) inManagedObjectContext:context ];
    
    p.name = [ NSString stringWithFormat:@"%@", [ datas objectForKey:@"Name" ] ];
    p.number = [ NSString stringWithFormat:@"%@", [ datas objectForKey:@"Number" ] ];
    
    NSError *error;
    [ context save:&error ];
}

////////////////////////////////////////////////////////////////////////////////

- ( NSMutableArray * )LoadPersonsData {
    
    AppDelegate *delegate = ( AppDelegate * )[ [ UIApplication sharedApplication ] delegate ];
    
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    NSEntityDescription *entity = [ NSEntityDescription entityForName:NSStringFromClass( [ Persons class ] ) inManagedObjectContext:context ];
    
    NSFetchRequest *fetch = [ [ NSFetchRequest alloc ] init ];
    
    [ fetch setEntity:entity ];
    
    NSError *error;
    
    NSArray *result = [ context executeFetchRequest:fetch error:&error ];
    
    NSDictionary *savedPersonsData = [ [ NSDictionary alloc ] init ];
    NSMutableArray *tablePersons = [ [ NSMutableArray alloc ] init ];
    
    for ( Persons *p in result ) {
        
        savedPersonsData = @{@"Name":p.name, @"Number":p.number};
        
        [ tablePersons addObject:savedPersonsData ];
        
        [ context save:&error ];
    }
    
    return tablePersons;
}

- ( void )DeletePersonsData:(NSString *)PersonsName {
    
    AppDelegate *delegate = ( AppDelegate * )[ [ UIApplication sharedApplication ] delegate ];
    
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    NSEntityDescription *entity = [ NSEntityDescription entityForName:NSStringFromClass( [ Persons class ] ) inManagedObjectContext:context ];
    
    NSFetchRequest *fetch = [ [ NSFetchRequest alloc ] init ];
    
    [ fetch setEntity:entity ];
    
    NSError *error;
    
    NSArray *result = [ context executeFetchRequest:fetch error:&error ];
    
    for ( Persons *p in result ) {
        
        if ( [ p.name isEqualToString:PersonsName  ] ) {
            
            [ context deleteObject:p ];
            [ context save:&error ];
        }
    }
}

////////////////////////////////////////////////////////////////////////////////

- ( NSMutableArray * )LoadMyData {
    
    AppDelegate *delegate = ( AppDelegate * )[ [ UIApplication sharedApplication ] delegate ];
    
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    NSEntityDescription *entity = [ NSEntityDescription entityForName:NSStringFromClass( [ MyData class ] ) inManagedObjectContext:context ];
    
    NSFetchRequest *fetch = [ [ NSFetchRequest alloc ] init ];
    
    [ fetch setEntity:entity ];
    
    NSError *error;
    
    NSArray *result = [ context executeFetchRequest:fetch error:&error ];
    
    //    NSLog( @"result : %@", result );
    
    //    NSDictionary *savedMyData = [ [ NSDictionary alloc ] init ];
    NSMutableArray *MyDatas= [ [ NSMutableArray alloc ] init ];
    
    //    for ( MyData *m in result ) {
    //
    ////        NSLog( @"result : %@ && [ m.myName isEqual:nil ] : %hhd", result, [ m.myName isEqual:nil ] );
    //
    //        if ( m.myName != nil ) {
    //
    //            savedMyData = @{ /*@"Name":m.myName, */@"Number":m.myNumber };
    //
    //            [ MyDatas addObject:savedMyData ];
    //        }
    //
    //    }
    
    NSMutableDictionary *data = [ [ NSMutableDictionary alloc ] init ];
    
    for ( MyData *m in result ) {
        if ( m.myNumber != nil ) {
            //            [ MyDatas addObject:@{ @"Number":m.myNumber } ];
            [ data setObject:m.myNumber forKey:@"Number" ];
        }else if ( m.message != nil ) {
            [ data setObject:m.message forKey:@"Message" ];
            [ data setObject:m.postTime forKey:@"Date" ];
        }
    }
    
    [ MyDatas addObject:data ];
    return MyDatas;
}

////////////////////////////////////////////////////////////////////////////////

- ( void )SaveMyData:( NSString * )number {
    
    AppDelegate *delegate = ( AppDelegate * )[ [ UIApplication sharedApplication ] delegate ];
    
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    MyData *m = [ NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass( [ MyData class ] ) inManagedObjectContext:context ];
    
    //    m.myName = [ NSString stringWithFormat:@"%@", Name ];
    m.myNumber = [ NSString stringWithFormat:@"%@", number ];
    
    NSError *error;
    [ context save:&error ];
}

////////////////////////////////////////////////////////////////////////////////

- ( void )SaveMymessage:( NSString * )message {
    
    AppDelegate *delegate = ( AppDelegate * )[ [ UIApplication sharedApplication ] delegate ];
    
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    MyData *m = [ NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass( [ MyData class ] ) inManagedObjectContext:context ];
    
    m.message = [ NSString stringWithFormat:@"%@", message ];
    
    NSDate *NowTime = [ NSDate dateWithTimeIntervalSinceNow:0.0f ];
    NSDateFormatter *formatter = [ [ NSDateFormatter alloc ] init ];
    [ formatter setDateFormat:@"yyyy年MM月dd日 HH時mm分ss秒" ];
    m.postTime = [ formatter stringFromDate:NowTime ];
    
    NSError *error;
    [ context save:&error ];
}

////////////////////////////////////////////////////////////////////////////////

- ( NSMutableArray * )LoadMymessage {
    
    AppDelegate *delegate = ( AppDelegate * )[ [ UIApplication sharedApplication ] delegate ];
    
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    NSEntityDescription *entity = [ NSEntityDescription entityForName:NSStringFromClass( [ MyData class ] ) inManagedObjectContext:context ];
    
    NSFetchRequest *fetch = [ [ NSFetchRequest alloc ] init ];
    
    [ fetch setEntity:entity ];
    
    NSError *error;
    
    NSArray *result = [ context executeFetchRequest:fetch error:&error ];
    
    //    NSLog( @"result : %@", result );
    
    NSMutableDictionary *savedMymessage = [ [ NSMutableDictionary alloc ] init ];
    NSMutableArray *Mymessage= [ [ NSMutableArray alloc ] init ];
    
    for ( MyData *m in result ) {
        
        if ( m.message == nil ) {
            
            //            [ savedMymessage addEntriesFromDictionary:@{ /*@"Name":m.myName,*/ @"Number":m.myNumber } ];
            
        }else {
            
            NSDictionary *dicmessage = [ [ NSDictionary alloc ] init ];
            dicmessage = @{ @"Message":m.message, @"Date":m.postTime };
            [ savedMymessage addEntriesFromDictionary:dicmessage ];
            
            [ Mymessage addObject:savedMymessage ];
        }
    }
    
    return Mymessage;
}

////////////////////////////////////////////////////////////////////////////////

- ( void )SaveGetdatas:( NSMutableArray * )getdatas {
    
    AppDelegate *delegate = ( AppDelegate * )[ [ UIApplication sharedApplication ] delegate ];
    
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    GetDatas *g = [ NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass( [ GetDatas class ] ) inManagedObjectContext:context ];
    
    //    m.myName = [ NSString stringWithFormat:@"%@", Name ];
    //    m.myNumber = [ NSString stringWithFormat:@"%@", Number ];
    //    m.message = [ NSString stringWithFormat:@"%@", message ];
    NSData *datas = [ [ NSData alloc ] init ];
    datas = [ NSKeyedArchiver archivedDataWithRootObject:getdatas ];
    
    g.getdatas = datas;
    
    
    NSError *error;
    [ context save:&error ];
}

- ( void )SaveAllGetdatas:( NSMutableArray * )allgetdatas {
    
    AppDelegate *delegate = ( AppDelegate * )[ [ UIApplication sharedApplication ] delegate ];
    
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    GetDatas *g = [ NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass( [ GetDatas class ] ) inManagedObjectContext:context ];
    
    //    m.myName = [ NSString stringWithFormat:@"%@", Name ];
    //    m.myNumber = [ NSString stringWithFormat:@"%@", Number ];
    //    m.message = [ NSString stringWithFormat:@"%@", message ];
    NSData *datas = [ [ NSData alloc ] init ];
    datas = [ NSKeyedArchiver archivedDataWithRootObject:allgetdatas ];
    
    [ g.allgetdatas setValue:datas forKey:@"Allgetdatas" ];
    
    NSError *error;
    [ context save:&error ];
}

- ( NSMutableArray * )LoadAllGetdatas {
    
    AppDelegate *delegate = ( AppDelegate * )[ [ UIApplication sharedApplication ] delegate ];
    
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    NSEntityDescription *entity = [ NSEntityDescription entityForName:NSStringFromClass( [ GetDatas class ] ) inManagedObjectContext:context ];
    
    NSFetchRequest *fetch = [ [ NSFetchRequest alloc ] init ];
    
    [ fetch setEntity:entity ];
    
    NSError *error;
    
    NSArray *result = [ context executeFetchRequest:fetch error:&error ];
    
    NSMutableArray *arrallgetdatas = [ [ NSMutableArray alloc ] init ];
    
    for( GetDatas *g in result ) {
        
        [ arrallgetdatas addObjectsFromArray:[ NSKeyedUnarchiver unarchiveObjectWithData:g.allgetdatas ] ];
    }
    
    return arrallgetdatas;
}

- ( void )DeleteAllgetdatas {
    
    AppDelegate *delegate = ( AppDelegate * )[ [ UIApplication sharedApplication ] delegate ];
    
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    NSEntityDescription *entity = [ NSEntityDescription entityForName:NSStringFromClass( [ GetDatas class ] ) inManagedObjectContext:context ];
    
    NSFetchRequest *fetch = [ [ NSFetchRequest alloc ] init ];
    
    [ fetch setEntity:entity ];
    
    NSError *error;
    
    NSArray *result = [ context executeFetchRequest:fetch error:&error ];
    
    for ( GetDatas *g in result ) {
        
        if ( g.allgetdatas ) {
            [ context deleteObject:g ];
            [ context save:&error ];
        }
    }
}

- ( NSMutableArray * )LoadGetdatas {
    
    AppDelegate *delegate = ( AppDelegate * )[ [ UIApplication sharedApplication ] delegate ];
    
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    NSEntityDescription *entity = [ NSEntityDescription entityForName:NSStringFromClass( [ GetDatas class ] ) inManagedObjectContext:context ];
    
    NSFetchRequest *fetch = [ [ NSFetchRequest alloc ] init ];
    
    [ fetch setEntity:entity ];
    
    NSError *error;
    
    NSArray *result = [ context executeFetchRequest:fetch error:&error ];
    
    NSMutableArray *arrdatas = [ [ NSMutableArray alloc ] init ];
    
    for( GetDatas *g in result ) {
        //        if( g.getdatas ) {
        [ arrdatas addObjectsFromArray:[ NSKeyedUnarchiver unarchiveObjectWithData:g.getdatas ] ];
        //        }
    }
    
    //    [ context delete:g.getdatas ];
    
    return arrdatas;
}

- ( void )DeleteMymessage {
    
    AppDelegate *delegate2 = ( AppDelegate * )[ [ UIApplication sharedApplication ] delegate ];
    
    NSManagedObjectContext *context2 = delegate2.managedObjectContext;
    
    NSEntityDescription *entity2 = [ NSEntityDescription entityForName:NSStringFromClass( [ MyData class ] ) inManagedObjectContext:context2 ];
    
    NSFetchRequest *fetch2 = [ [ NSFetchRequest alloc ] init ];
    
    [ fetch2 setEntity:entity2 ];
    
    NSError *error2;
    
    NSArray *result2 = [ context2 executeFetchRequest:fetch2 error:&error2 ];
    
    for ( MyData *m in result2 ) {
        
        if ( m.message ) {
            [ context2 deleteObject:m ];
            [ context2 save:&error2 ];
        }
    }
}

- ( void )DeleteGetdatas {
    
    AppDelegate *delegate = ( AppDelegate * )[ [ UIApplication sharedApplication ] delegate ];
    
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    NSEntityDescription *entity = [ NSEntityDescription entityForName:NSStringFromClass( [ GetDatas class ] ) inManagedObjectContext:context ];
    
    NSFetchRequest *fetch = [ [ NSFetchRequest alloc ] init ];
    
    [ fetch setEntity:entity ];
    
    NSError *error;
    
    NSArray *result = [ context executeFetchRequest:fetch error:&error ];
    
    for ( GetDatas *g in result ) {
        
        [ context deleteObject:g ];
        [ context save:&error ];
    }
}

@end
