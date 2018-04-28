//
//  PersonsTableViewController.m
//  wt
//
//  Created by MUKBC on 2014/09/02.
//  Copyright (c) 2014年 Hiroki Nomura. All rights reserved.
//

#import "PersonsTableViewController.h"
#import "EditData.h"

@interface PersonsTableViewController () {
    
    EditData *Editdata;
}

@end

@implementation PersonsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Editdata = [ [ EditData alloc ] init ];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSMutableArray *counter = [ [ NSMutableArray alloc ] init ];
    counter = Editdata.LoadPersonsData;
    
    NSLog( @"counter.count : %lu", (unsigned long)counter.count );
    
    return counter.count;
}


- ( UITableViewCell * )tableView:( UITableView * )tableView cellForRowAtIndexPath:( NSIndexPath * )indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [ tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    
    if ( cell == nil ) {
        
        cell = [ [ UITableViewCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ];
    }
    
    cell.textLabel.text = [ NSString stringWithFormat:@"%@ %@",
                           [ [ Editdata.LoadPersonsData  objectAtIndex:indexPath.row ] objectForKey:@"Name" ],
                           [ [ Editdata.LoadPersonsData objectAtIndex:indexPath.row ] objectForKey:@"Number" ] ];
    
    return cell;
}

// テーブルビューの編集モード
- ( void )tableView:( UITableView * )tableView commitEditingStyle:( UITableViewCellEditingStyle )editingStyle forRowAtIndexPath:( NSIndexPath * )indexPath
{
    if ( editingStyle == UITableViewCellEditingStyleDelete ) {
        // ここで配列などデータの削除を行う
        
        [ Editdata DeletePersonsData:[ NSString stringWithFormat:@"%@", [ [ Editdata.LoadPersonsData  objectAtIndex:indexPath.row ] objectForKey:@"Name" ] ] ];
        
        // 削除ボタンを押下されたボタンの行を削除
        [ tableView deleteRowsAtIndexPaths:[ NSArray arrayWithObject:indexPath ] withRowAnimation:UITableViewRowAnimationFade ];
        
        [ tableView reloadData ];
    }
}

@end
