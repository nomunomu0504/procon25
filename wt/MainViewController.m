//
//  MainViewController.m
//  wt
//
//  Created by MUKBC on 2014/08/31.
//  Copyright (c) 2014年 Hiroki Nomura. All rights reserved.
//

#import "MainViewController.h"
#import "Reachability.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <CoreData/CoreData.h>
#import "Persons.h"
#import "EditData.h"
#import <UIKit/UIKit.h>
#import "PostMessageViewController.h"
#import "CustomTableViewCell.h"
#import "R9HTTPRequest.h"

#define RGBA( r, g, b, a ) [ UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a ]

//#import "AddresViewController.h"

@interface MainViewController () {
    EditData *Editdata;
    PostMessageViewController *message;
    CustomTableViewCell *cell;
    CustomTableViewCell *customcell;
    BOOL addflag;
    //    Persons *Persons;
}

@end

@implementation MainViewController

@synthesize url, senddata, NameString, PhoneNumberString, NowString, ownpeerID,
receiveDatas, receivedData, Mysession, getdatas, curReach, netStatus,
alerttag, infotableview, sendData, sessionflag, initflag, Allgetdatas, Namegetdatas,
sendinternetflag, sendformat;

////////////////////////////////////////////////////////////////////////////////////

- ( void )viewDidLoad
{
    [ super viewDidLoad ];
    
    customcell = [ [ CustomTableViewCell alloc ] init ];
    
    senddata = [ [ NSData alloc ] init ];
    
    Allgetdatas = [ [ NSMutableArray alloc ] init ];
    
    getdatas = [ [ NSMutableArray alloc ] init ];
    
    Editdata = [ [ EditData alloc ] init ];
    
    message = [ [ PostMessageViewController alloc ] init ];
    
    sendData = [ [ NSMutableArray alloc ] init ];
    
    infotableview.dataSource = self;
    infotableview.delegate = self;
    
    infotableview.separatorColor = RGBA(245, 245, 245, 1);
    
    infotableview.backgroundColor = RGBA(245, 245, 245, 1);
    
    UINib *nib = [ UINib nibWithNibName:@"CustomCell" bundle:nil ];
    [ infotableview registerNib:nib forCellReuseIdentifier:@"Cell"];
    [self.searchDisplayController.searchResultsTableView registerNib:nib forCellReuseIdentifier:@"Cell"];
    
    [ UITableViewCell appearance ].separatorInset = UIEdgeInsetsZero;
    
    //    [ self startsession ];
}

////////////////////////////////////////////////////////////////////////////////////

- ( void )didReceiveMemoryWarning
{
    [ super didReceiveMemoryWarning ];
    // Dispose of any resources that can be recreated.
}

////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Table view data source
- ( NSInteger )numberOfSectionsInTableView:( UITableView * )tableView {
    
    return 1;
}

////////////////////////////////////////////////////////////////////////////////////

- ( NSInteger )tableView:( UITableView * )tableView numberOfRowsInSection:( NSInteger )section {
    
    return getdatas.count;
}

////////////////////////////////////////////////////////////////////////////////////

- ( UITableViewCell * )tableView:( UITableView * )tableView cellForRowAtIndexPath:( NSIndexPath * )indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    [ cell reloadInputViews ];
    
    cell = [ infotableview dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if ( [ getdatas count ] > indexPath.row ) {
        
        cell.NameLabel.text = [ NSString stringWithFormat:@"%@",
                               [ [ getdatas objectAtIndex:indexPath.row ] objectForKey:@"Name" ] ];
        
        cell.DateLabel.text = [ NSString stringWithFormat:@"%@",
                               [ [ getdatas objectAtIndex:indexPath.row ] objectForKey:@"Date" ] ];
        
        cell.MessageLabel.text = [ NSString stringWithFormat:@"%@",
                                  [ [ getdatas objectAtIndex:indexPath.row ] objectForKey:@"Message" ] ];
        
        return cell;
    }else {
        
        UITableViewCell *cell2 = [ [ UITableViewCell alloc ] init ];
        return cell2;
    }
}

////////////////////////////////////////////////////////////////////////////////////

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 選択状態の解除をします。
}

////////////////////////////////////////////////////////////////////////////////////

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [ self sizeWithFontEx:[ UIFont systemFontOfSize:17 ] constrainedToSize:CGSizeMake(230, 21) lineBreakMode:NSLineBreakByCharWrapping ];
    
    float height = 170.0f; // セルの最低限の高さ
    
    // 元の UILabel よりも高さが高ければ高さを補正する
    float h = [ self sizeWithFontEx:[ UIFont systemFontOfSize:17 ] constrainedToSize:CGSizeMake(230, 21) lineBreakMode:NSLineBreakByCharWrapping ].height - cell.MessageLabel.frame.size.height;
    
    if (h > 0) {
        height += h;
    }
    
    return height;
}



- (void)relayoutTableView
{
    // TableViewの全行のセルを取り出し、レイアウト調整処理を呼ぶ
    for ( int i = 0; i <[ infotableview numberOfRowsInSection:0 ]; i++ ) {
        
        cell = (CustomTableViewCell *)[ infotableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] ];
        [cell drawRect:cell.frame];
    }
}





- (CGSize)sizeWithFontEx:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode {
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = lineBreakMode;
    style.alignment = NSTextAlignmentLeft;
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName : font,
                                 NSParagraphStyleAttributeName : style
                                 };
    
    CGRect rect = [cell.MessageLabel.text boundingRectWithSize:size
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:attributes
                                                       context:nil];
    
    //    customcell.content.frame.size.height + rect.size.height;
    
    return rect.size;
}

////////////////////////////////////////////////////////////////////////////////////

- ( void )viewWillAppear:(BOOL)animated {
    
    [ Mysession disconnectFromAllPeers ];
    
    getdatas = [ [ NSMutableArray alloc ] init ];
    
    [ getdatas addObjectsFromArray:Editdata.LoadGetdatas ];
    
    Allgetdatas = [ [ NSMutableArray alloc ] init ];
    
    [ Allgetdatas addObjectsFromArray:Editdata.LoadAllGetdatas ];
    
    NSLog(@"getdatas count : %lu", (unsigned long)getdatas.count );
    
    [ infotableview reloadData ];
    
    sendData = [ [ NSMutableArray alloc ] init ];
    
    [ sendData addObjectsFromArray:Editdata.LoadMyData ];
    
    //    [ self startsession ];
    
    curReach = [Reachability reachabilityForInternetConnection];
    netStatus = [curReach currentReachabilityStatus];
    
    dispatch_async( dispatch_get_main_queue(), ^{
        
        [self CheckNetStatus];
    } );
    
    NSLog( @"MyData : %@", sendData );
}

/////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////

- ( void )startsession {
    
    //    [ Mysession disconnectFromAllPeers ];
    
    //    if ( !sessionflag ) {
    
    Mysession = [ [ GKSession alloc ] initWithSessionID:Session_id
                                            displayName:nil
                                            sessionMode:GKSessionModePeer ];
    
    Mysession.delegate = self;
    
    [ Mysession setDataReceiveHandler:self withContext:nil ];
    
    sessionflag = YES;
    //        }
    
    
    Mysession.available = YES; //通信開始
}

/////////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////////////

#pragma mark GKSessionDelegate

- (void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error {
    
    NSLog(@"%@", [NSString stringWithFormat:@"%@ とうまく接続できない。 (%@)",peerID,[error localizedDescription]] );
}

/////////////////////////////////////////////////////////////////////////////////////////

- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID {
    
    //    NSLog(@"status : %hhd", [ peerID isEqualToString:[ NSString stringWithFormat:@"%@", Mysession.peerID ] ]);
    
    NSLog(@"%@", [NSString stringWithFormat:@"%@ から接続要請！",peerID] );
    
    NSError *error;
    
    [ Mysession acceptConnectionFromPeer:peerID error:&error];
    
    if( ! [Mysession acceptConnectionFromPeer:peerID error:&error] ) {
        
        NSLog(@"%@", [NSString stringWithFormat:@"%@ と接続できなかった… (%@)",peerID,[error localizedDescription]] );
    } else {
        
        NSLog(@"%@", [NSString stringWithFormat:@"%@ の接続を許可した！",peerID] );
        
    }
}

/////////////////////////////////////////////////////////////////////////////////////////

- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state {
    
    switch (state) {
        case GKPeerStateAvailable:
            
            NSLog(@"%@", [NSString stringWithFormat:@"%@ を見つけた！",peerID] );
            NSLog(@"%@", [NSString stringWithFormat:@"%@ に接続しに行く！",peerID] );
            [ Mysession connectToPeer:peerID withTimeout:10.0f ];
            
            break;
            
        case GKPeerStateUnavailable:
            
            NSLog(@"%@", [NSString stringWithFormat:@"%@ を見失った！",peerID] );
            break;
            
        case GKPeerStateConnected: {
            
            NSLog(@"%@", [NSString stringWithFormat:@"%@ が接続した！",peerID] );
            
            sendData = Editdata.LoadMyData;
            
            NSLog( @"sendData : %@", sendData );
            
            if ( sendData.count != 0 ) {
                
                NSData *data = [ [ NSData alloc ] init ];
                
                Editdata = [ [ EditData alloc ] init ];
                
                data = [ NSKeyedArchiver archivedDataWithRootObject:sendData ];
                
                //                [ Mysession sendData:data
                //                             toPeers:[NSArray arrayWithObject:peerID]
                //                        withDataMode:GKSendDataUnreliable
                //                               error:nil ];
                
                [ Mysession sendDataToAllPeers:data
                                  withDataMode:GKSendDataUnreliable
                                         error:nil ];
                
                //                NSData *alldata = [ [ NSData alloc ] init ];
                //                alldata = [ NSKeyedArchiver archivedDataWithRootObject:Allgetdatas ];
                //
                //                [ Mysession sendData:alldata
                //                             toPeers:[NSArray arrayWithObject:peerID]
                //                        withDataMode:GKSendDataUnreliable
                //                               error:nil ];
                
            }else {
                
                Editdata = [ [ EditData alloc ] init ];
                
                NSData *data = [ [ NSData alloc ] init ];
                
                [ sendData addObject:Editdata.LoadMyData ];
                
                data = [ NSKeyedArchiver archivedDataWithRootObject:sendData ];
                
                //                [ Mysession sendData:data
                //                             toPeers:[ NSArray arrayWithObject:peerID ]
                //                        withDataMode:GKSendDataUnreliable
                //                               error:nil ];
                
                [ Mysession sendDataToAllPeers:data
                                  withDataMode:GKSendDataUnreliable
                                         error:nil ];
                
                //                NSData *alldata = [ [ NSData alloc ] init ];
                //                alldata = [ NSKeyedArchiver archivedDataWithRootObject:Allgetdatas ];
                //
                //                [ Mysession sendData:alldata
                //                             toPeers:[NSArray arrayWithObject:peerID]
                //                        withDataMode:GKSendDataUnreliable
                //                               error:nil ];
            }
            
            break;
        }
            
        case GKPeerStateDisconnected:
            
            NSLog(@"%@", [NSString stringWithFormat:@"%@ が切断された！",peerID] );
            break;
            
        case GKPeerStateConnecting:
            
            NSLog(@"%@", [NSString stringWithFormat:@"%@ が私を発見！",peerID] );
            break;
            
        default:
            break;
    }
    //    }
}

/////////////////////////////////////////////////////////////////////////////////////////

- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer inSession:(GKSession *)session context:(void *)context {
    
    NSMutableArray *datas = [ [ NSMutableArray alloc ] initWithArray:[ NSKeyedUnarchiver unarchiveObjectWithData:data ] ];
    
    //    [ Allgetdatas addObjectsFromArray:datas ];
    
    [ Editdata SaveAllGetdatas:datas ];
    
    for ( NSMutableArray *data in datas ) {
        
        int count = 0;
        
        for ( int i = 0; i < [ [ Editdata LoadPersonsData ] count ]; i++ ) {
            
            if ( [ [ [ datas objectAtIndex:0 ] objectForKey:@"Number" ] isEqualToString:[ NSString stringWithFormat:@"%@", [ [ Editdata.LoadPersonsData objectAtIndex:i ] objectForKey:@"Number" ] ] ] ) {
                
                
                [ [ datas objectAtIndex:0 ] setObject:[ [ Editdata.LoadPersonsData objectAtIndex:i ] objectForKey:@"Name" ] forKey:@"Name" ];
                
                //1
                NSLog(@"1 : getdatas count : %lu", (unsigned long)getdatas.count );
                
                if ( getdatas.count != 0 ) {
                    
                    for( int i = 0; i < getdatas.count; i++ ) {
                        
                        addflag = NO;
                        
                        if ( [ [ [ getdatas objectAtIndex:i ] objectForKey:@"Number" ] isEqualToString:[ [ datas objectAtIndex:0 ] objectForKey:@"Number" ] ] ) {
                            
                            [ getdatas replaceObjectAtIndex:i withObject:[ NSNull null ] ];
                            
                            NSIndexSet *j = [ [ NSIndexSet alloc ] initWithIndex:i ];
                            [ getdatas replaceObjectsAtIndexes:j withObjects:datas ];
                        
                        }else {
                            
                            count++;
                            
                            if ( addflag ) {
                                
                                //----//
                                if ( [ [ getdatas objectAtIndex:0 ] objectForKey:@"Message" ] == nil ) {
                                    
                                    [ [ [ getdatas objectAtIndex:0 ] objectForKey:@"Message" ] replaceObjectAtIndex:0 withObject:[ NSString stringWithFormat:@"メッセージはありません" ] ];
                                }
                                //----//
                                
                                [ getdatas addObjectsFromArray:datas ];
                                
                            }else if ( count == getdatas.count ) {
                                
                                [ getdatas addObjectsFromArray:datas ];
                            }
                        }
                    }
                    
                    [ self sendtointernet ];
                    
                }else {
                    
                    [ getdatas addObjectsFromArray:datas ];
                }
            }
            
            [ Editdata DeleteGetdatas ];
            [ infotableview reloadData ];
            
            [ Editdata SaveGetdatas:getdatas ];
            [ infotableview reloadData ];
            
        }
    }
}

/////////////////////////////////////////////////////////////////////////////////////////

- (void)CheckNetStatus {
    
    switch ( netStatus ) {
        case NotReachable: //圏外
            NSLog(@"圏外");
            sendinternetflag = NO;
            sendformat = @"NO";
            [ self startsession ];
            break;
            
        case ReachableViaWWAN: //3G or 4G/LTE
            NSLog(@"3G or 4G/LTE");
            sendinternetflag = YES;
            sendformat = @"LTE";
            [ self startsession ];
            break;
            
            
        case ReachableViaWiFi: //wifi
            NSLog(@"Wi-Fi");
            sendinternetflag = YES;
            sendformat = @"WiFi";
            [ self startsession ];
            break;
    }
}

/////////////////////////////////////////////////////////////////////////////////////////

- ( void )sendtointernet {
    
    BOOL flag = NO;
    
    if ( sendinternetflag ) {
        
        if ( getdatas.count > 0 ) {
            
            for ( int i = 0; i < [ getdatas count ]; i++ ) {
                
                NSString *worldName = [ [ NSString alloc ] init ];
                worldName = [ [ getdatas objectAtIndex:i ] objectForKey:@"Name" ];
                
                NSString *worldNumber = [ [ NSString alloc ] init ];
                worldNumber = [ [  getdatas objectAtIndex:i ] objectForKey:@"Number" ];
                
                NSString *worldMessage = [ [ NSString alloc ] init ];
                worldMessage = [ [ getdatas objectAtIndex:i ] objectForKey:@"Message" ];
                
                NSString *worldDate = [ [ NSString alloc ] init ];
                worldDate = [ [ getdatas objectAtIndex:i ] objectForKey:@"Date" ];
                
                NSString *strURL = [ [ NSString alloc] init ];
                strURL = [ NSString stringWithFormat:@"http://xxxxx.xxxx.xxx/main.php?Name=%@&Date=%@&Id=%@&Comment=%@", worldName, worldDate, worldNumber, worldMessage ];
                
                NSString *encodedstrURL = [ [ NSString alloc ] init ];
                encodedstrURL = [ strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
                
                NSString *strURLpi = [ [ NSString alloc] init ];
                strURLpi = [ NSString stringWithFormat:@"http://192.168.2.2/main.php?Name=%@&Date=%@&Id=%@&Comment=%@", worldName, worldDate, worldNumber, worldMessage ];
                
                NSString *encodedstrURLpi = [ [ NSString alloc ] init ];
                encodedstrURLpi = [ strURLpi stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
                
                if ( [ sendformat isEqualToString:@"NO" ] ) {
                    
                    flag = NO;
                    
                }else if( [ sendformat isEqualToString:@"LTE" ] ) {
                    
                    url = [ NSURL URLWithString:encodedstrURL ];
                    [ self getAsync:url ];
                    flag = YES;
                    
                }else if( [ sendformat isEqualToString:@"WiFi" ] ) {
                    
                    url = [ NSURL URLWithString:encodedstrURLpi ];
                    [ self getAsync:url ];
                    url = [ NSURL URLWithString:encodedstrURL ];
                    [ self getAsync:url ];
                    flag = YES;
                    
                }else {
                    
                    flag = NO;
                }
            }
        }
    }
}

// HTTP-GET
- ( void )getAsync:( NSURL *)strURL {
    
    NSLog(@"%@#%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    
    // Create the url-request.
    //    NSURL *url = [ NSURL URLWithString:strURL ];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:strURL ];
    
    // Set the method(HTTP-GET)
    [request setHTTPMethod:@"GET"];
    
    // Send the url-request.
    [ NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( data ) {
                                   
                                   NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   NSLog(@"result: %@", result);
                                   
                               } else {
                                   
                                   NSLog(@"error: %@", error);
                                   
                               }
                           } ];
    
}
@end

