//
//  PostMessageViewController.m
//  wt
//
//  Created by MUKBC on 2014/09/02.
//  Copyright (c) 2014年 Hiroki Nomura. All rights reserved.
//

#import "PostMessageViewController.h"
#import "EditData.h"
#import "MainViewController.h"

#define Session_id @"_WT_"

@interface PostMessageViewController () {
    
    EditData *Editdata;
    MainViewController *mainviewcontroller;
    MainViewController *main;
    NSDictionary *datas;
}

@end

@implementation PostMessageViewController

@synthesize NowInfoText, ownpeerID, Mysession, arrdatas, flag;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    mainviewcontroller = [ [ MainViewController alloc ] init ];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- ( void )viewWillAppear:(BOOL)animated {
    
    Editdata = [ [ EditData alloc ] init];
    
    [ NowInfoText becomeFirstResponder ];
}

- (IBAction)SendButton:(id)sender {
    
    [ Editdata DeleteMymessage ];
    
    [ Editdata SaveMymessage:NowInfoText.text ];
    
    NSLog( @"\n Text : %@ \n MyName : %@ \n PostDate : %@ \n MyNumber : %@",
          NowInfoText.text,
          [ [ Editdata.LoadMyData objectAtIndex:0 ] objectForKey:@"Name" ],
          [ [ Editdata.LoadMymessage objectAtIndex:0 ] objectForKey:@"Date" ],
          [ [ Editdata.LoadMyData objectAtIndex:0 ] objectForKey:@"Number" ] );
    
//    [ mainviewcontroller startsession ];
    
    [ self.navigationController popToRootViewControllerAnimated:YES ];
}




@end
