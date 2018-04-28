//
//  SettingViewController.m
//  wt
//
//  Created by MUKBC on 2014/09/02.
//  Copyright (c) 2014年 Hiroki Nomura. All rights reserved.
//

#import "SettingViewController.h"
#import "AppDelegate.h"
#import "Persons.h"
#import "EditData.h"
#import "MyData.h"

@interface SettingViewController () {
    
    EditData *Editdata;
}

@end

@implementation SettingViewController

@synthesize MyID, PersonsName, PersonsNumber, addbutton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Editdata = [ [ EditData alloc ] init ];
    
    MyID.text = [ NSString stringWithFormat:@"自分のID : %@", [ [ Editdata.LoadMyData objectAtIndex:0 ] objectForKey:@"Number" ] ];
    
    [ [ addbutton layer ] setCornerRadius:10.0 ];
    [ addbutton setClipsToBounds:YES ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (IBAction)backbutton:(id)sender {
//    
//    UIStoryboard *Storyboard = [ UIStoryboard storyboardWithName:@"Steps" bundle:[ NSBundle mainBundle ] ];
//    [ self presentViewController:[ Storyboard instantiateViewControllerWithIdentifier:@"FirstVC"] animated:YES completion:^() {} ];
//}

- (IBAction)deleatbutton:(id)sender {
    
    [ Editdata DeleteGetdatas ];
    
    [ Editdata DeleteMymessage ];
}

- (IBAction)AddPersonsData:(id)sender {
    
    NSDictionary *PersonsInfo = [ [ NSDictionary alloc ] init ];
    PersonsInfo = @{ @"Name":PersonsName.text, @"Number":PersonsNumber.text };
    
    [ Editdata SavePersonsData:PersonsInfo ];
    
//    [ self dismissViewControllerAnimated:YES completion:nil ];
    
    UIStoryboard *Storyboard = [ UIStoryboard storyboardWithName:@"Main" bundle:[ NSBundle mainBundle ] ];
    [ self presentViewController:[ Storyboard instantiateViewControllerWithIdentifier:@"StartVC"] animated:YES completion:^() {} ];
    
}
@end
