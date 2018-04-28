//
//  infoViewController.m
//  wt
//
//  Created by MUKBC on 2014/10/05.
//  Copyright (c) 2014年 Hiroki Nomura. All rights reserved.
//

#import "infoViewController.h"
#import "RMDemoStepViewController.h"
#import "RMStepsController.h"
#import "EditData.h"
#import "RMNavStepsViewController.h"

@interface infoViewController () {
    
    RMDemoStepViewController *demostep;
    RMNavStepsViewController *Navigationstep;
    EditData *Editdata;
}

@end

@implementation infoViewController

@synthesize PersonsNumber, PersonsName, MyNumer;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    demostep = [ [ RMDemoStepViewController alloc ] init ];
    Navigationstep = [ [ RMNavStepsViewController alloc ] init ];
    
    Editdata = [ [ EditData alloc ] init ];
    
    NSMutableArray *mydata = [ [ NSMutableArray alloc ] initWithArray:Editdata.LoadMyData ];
    
    MyNumer.text = [ [ NSString alloc ] init ];
    MyNumer.text = [ NSString stringWithFormat:@" あなたのID : %@ ",
                    [ [ mydata objectAtIndex:0 ] objectForKey:@"Number" ] ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (IBAction)nextStepTapped:(id)sender {
    
    if ( [ PersonsName.text isEqualToString:@"" ] || [ PersonsNumber.text isEqualToString:@"" ] ) {
        
        UIAlertView *alert = [ [ UIAlertView alloc ] initWithTitle:@"エラー"
                                                           message:@"入力されていない項目があります"
                                                          delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
        [ alert show ];
        
    }else {
        
        [ Editdata SavePersonsData:@{ @"Name":PersonsName.text, @"Number":PersonsNumber.text } ];
        
        [ self.stepsController showNextStep ];
    }
}

- (IBAction)previousStepTapped:(id)sender {
    [ self.stepsController showPreviousStep ];
}

- (IBAction)closeKeyBoard:(id)sender {
    
    //returnキーでのkeyboard収納
    [ self resignFirstResponder ];
}
@end
