//
//  AddressViewController.m
//  wt
//
//  Created by MUKBC on 2014/08/31.
//  Copyright (c) 2014年 Hiroki Nomura. All rights reserved.
//

#import "AddressViewController.h"
#import "EditData.h"
#import "Persons.h"

@interface AddressViewController () {
    
    EditData *Editdata;
}

@end

@implementation AddressViewController

@synthesize addressTable, tableviewpersons, arrayData, firstName,
lastName, PhoneNumber, isEditing;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    Editdata = [ [ EditData alloc] init ];
    
    isEditing = NO;
    self.addressTable.dataSource = self;
    self.addressTable.delegate = self;
    
    if ( tableviewpersons.count == 0 ) {
        tableviewpersons = [ NSMutableArray array ];
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- ( void )viewWillAppear:( BOOL )animated {
    
    [ addressTable reloadData ];
}

- ( BOOL )shouldAutorotateToInterfaceOrientation:( UIInterfaceOrientation )interfaceOrientation {
    
    return ( interfaceOrientation == UIInterfaceOrientationPortrait );
}

#pragma mark - Table view data source
- ( NSInteger )numberOfSectionsInTableView:( UITableView * )tableView {
    
    return 1;
}

- ( NSInteger )tableView:( UITableView * )tableView numberOfRowsInSection:( NSInteger )section {
    
    return tableviewpersons.count;
}

- ( UITableViewCell * )tableView:( UITableView * )tableView cellForRowAtIndexPath:( NSIndexPath * )indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [ addressTable dequeueReusableCellWithIdentifier:CellIdentifier ];
    
    if ( cell == nil ) {
        
        cell = [ [ UITableViewCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ];
    }
    
    cell.textLabel.text = [ NSString stringWithFormat:@"%@ %@",
                           [ [ tableviewpersons objectAtIndex:indexPath.row ] objectForKey:@"last" ],
                           [ [ tableviewpersons objectAtIndex:indexPath.row ] objectForKey:@"first" ] ];
    return cell;
}

//編集モード
- ( void )tableView:( UITableView * )tableView commitEditingStyle:( UITableViewCellEditingStyle )editingStyle forRowAtIndexPath:( NSIndexPath * )indexPath {
    
    if ( editingStyle == UITableViewCellEditingStyleDelete ) {
        
        if ( tableviewpersons.count<1 ) {
            
            NSLog( @"addressTable Is nil" );
            [ addressTable setEditing:NO animated:YES ];
        } else {
            
            //削除時の操作 選択された行に対応するデータをpersonsから消去
            NSLog( @"addressTable has phonenumbers" );
            [ tableviewpersons removeObjectAtIndex:indexPath.row ];
            [ tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationFade ];
        }
    }
}

//テーブルビューの項目を選択したとき
- ( void )tableView:( UITableView * )tableView didSelectRowAtIndexPath:( NSIndexPath * )indexPath {
    
    NSLog( @"First: %@", [ [ tableviewpersons objectAtIndex:indexPath.row ] objectForKey:@"first" ] );
    NSLog( @"Last: %@", [ [ tableviewpersons objectAtIndex:indexPath.row ] objectForKey:@"last" ] );
    NSLog( @"PhoneNumber: %@", [ [ tableviewpersons objectAtIndex:indexPath.row ] objectForKey:@"Phone" ] );
}

/////////////////////////////////////////////////////////
/* ---------------- アドレス帳選択 −−−−−−−−−−−−−−−− */
/////////////////////////////////////////////////////////

//peoplePickerモーダルを開く
- ( IBAction )addPerson:( id )sender {
    
    ABPeoplePickerNavigationController *picker = [ [ ABPeoplePickerNavigationController alloc ]init ];
    picker.peoplePickerDelegate = self;
    [ self presentViewController:picker animated:YES completion:^() {} ];
}

//peoplePickerをキャンセル
- ( void )peoplePickerNavigationControllerDidCancel:( ABPeoplePickerNavigationController * )peoplePicker {
    
    [ self dismissViewControllerAnimated:YES completion:^() {} ];
}

//peoplePickerで誰かを選択した
- ( BOOL )peoplePickerNavigationController:( ABPeoplePickerNavigationController * )peoplePicker shouldContinueAfterSelectingPerson:( ABRecordRef )person {
    
    ABMultiValueRef PhoneNumberRef = ( ABMultiValueRef )ABRecordCopyValue( person,kABPersonPhoneProperty );
    
    //選択した人物が持つ番号の数
    long int PhoneNumberCount = ABMultiValueGetCount( PhoneNumberRef );
    firstName = ( __bridge NSString * )( ABRecordCopyValue ( person, kABPersonFirstNameProperty ) );
    lastName = (  __bridge NSString * )( ABRecordCopyValue ( person, kABPersonLastNameProperty ) );
    
    //名前が登録されていなかったら"空白"を自動追加
    if ( lastName == NULL ) {
        
        lastName = @" ";
    }
    
    if ( firstName == NULL ) {
        
        firstName = @" ";
    }
    
    //番号が1つもない
    if ( PhoneNumberCount == 0 ) {
        
        NSLog( @"電話番号が登録されていません" );
        return NO;
    }
    
    //番号が複数ある
    else if ( PhoneNumberCount >1 ) {
        
        //次の詳細画面に番号しか出ないようにセット。return YESで詳細画面に進む
        [ peoplePicker setDisplayedProperties:[ NSArray arrayWithObject:[ NSNumber numberWithInt:kABPersonPhoneProperty ] ] ];
        return YES;
        
    } else {    //番号が1つしかない
        
        PhoneNumber = ( __bridge NSString * )ABMultiValueCopyValueAtIndex( PhoneNumberRef, 0 );
        
        //名前が登録されていなかったら"空白"を自動追加
        if ( lastName == NULL ) {
            
            lastName = @" ";
        }
        
        if ( firstName == NULL ) {
            
            firstName = @" ";
        }
        
        //////////////////////////////////////////////////////
        /*------------Core Dataへデータ保存−−−−−−−−−−−−−*/
        //////////////////////////////////////////////////////
        
        NSDictionary *selectedPerson = @{ @"first":firstName, @"last":lastName, @"Phone":PhoneNumber };
        
        [ Editdata SavePersonsData:selectedPerson ];
    
    }
    
    [self dismissViewControllerAnimated:YES completion:^() {}];
    return NO;
}

//詳細画面で選択したとき
//電話番号を複数持つ人は一つの番号だけを選択
- ( BOOL ) peoplePickerNavigationController:( ABPeoplePickerNavigationController * )peoplePicker shouldContinueAfterSelectingPerson:( ABRecordRef )person property:( ABPropertyID )property identifier:( ABMultiValueIdentifier )identifier {
    
    CFTypeRef multi = ABRecordCopyValue( person, property );
    CFIndex index = ABMultiValueGetIndexForIdentifier( multi, identifier );
    
    //選択された番号と人物を紐付けてpersonsに追加
    PhoneNumber = ( __bridge NSString * )ABMultiValueCopyValueAtIndex( multi, index );
    
    //名前が登録されていなかったら"空白"を自動追加
    if( lastName == NULL ) {
        
        lastName = @" ";
    }
    
    if( firstName == NULL ) {
        
        firstName = @" ";
    }
    
    //////////////////////////////////////////////////////
    /*------------Core Dataへデータ保存−−−−−−−−−−−−−*/
    //////////////////////////////////////////////////////
    
    NSDictionary *selectedPerson = @{ @"first":firstName, @"last":lastName, @"Phone":PhoneNumber };
    
    [ Editdata SavePersonsData:selectedPerson ];
    
    [ self dismissViewControllerAnimated:YES completion:^() {} ];
    return NO;
}



///////////////////////////////////////////////////////////
/*---------------- ActionButton関係 −−−−−−−−−−−−−−−−*/
///////////////////////////////////////////////////////////




//戻る(画面遷移)
- ( IBAction )BackButton:( id )sender {
    
    [ self dismissViewControllerAnimated:YES completion:^() {} ];
}


@end
