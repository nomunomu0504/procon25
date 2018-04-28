//
//  FirstViewController.m
//  wt
//
//  Created by MUKBC on 2014/08/31.
//  Copyright (c) 2014年 Hiroki Nomura. All rights reserved.
//

#import "FirstViewController.h"
#import "Persons.h"
#import "EditData.h"

#define RGBA( r, g, b, a ) [ UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a ]

@interface FirstViewController () {
    
    EditData *Editdata;
}

@end

@implementation FirstViewController

@synthesize MyData, UUID, uuid, startbutton;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UUID = [ [ NSString alloc ] init ];
    uuid = [ [ NSArray alloc ] init ];
    
    UUID = [ [ NSUUID UUID ] UUIDString ];
    uuid = [ UUID componentsSeparatedByString:@"-" ];
    
    _title_label.alpha = 0;
    _explanation_label.alpha = 0;
    _Button.alpha = 0;
    
    Editdata = [ [ EditData alloc ] init ];
    
    MyData = [ [ NSMutableArray alloc ] init ];
    
    [ MyData addObject:Editdata.LoadMyData ];
    
    [ [ startbutton layer ] setCornerRadius:10.0 ];
    [ startbutton setClipsToBounds:YES ];
}

- ( void )viewDidAppear:(BOOL)animated {
    
    if ( [ [[ MyData objectAtIndex:0 ] objectAtIndex:0 ] count ] == 0 ) {
        
        NSLog( @"MyData is NULL" );
        
        [ Editdata SaveMyData:[ NSString stringWithFormat:@"%@", uuid[0] ] ];
        
        //背景色をグラデーションに
        CAGradientLayer *gradient = [ CAGradientLayer layer ];
        gradient.frame = self.view.bounds;
        gradient.colors = [ NSArray arrayWithObjects:(id)[ RGBA(51, 102, 204, 1) CGColor ], (id)[ RGBA(42, 198, 255, 1) CGColor ], nil ];
        [ self.view.layer insertSublayer:gradient atIndex:0 ];
        
        [ self performSelector:@selector( sampleImageFadeIn ) withObject:nil afterDelay:1.0f ];
        [ self performSelector:@selector( FadeInButton ) withObject:nil afterDelay:1.5f ];
        
    } else {
        
        UIStoryboard *Main = [ UIStoryboard storyboardWithName:@"Main" bundle:[ NSBundle mainBundle ] ];
        [ self presentViewController:[ Main instantiateViewControllerWithIdentifier:@"StartVC"] animated:YES completion:^() {
            
            NSLog( @"NAME : %@ && NUMBER : %@",
                  [ [ Editdata.LoadMyData objectAtIndex:0 ] objectForKey:@"Name" ],
                  [ [ Editdata.LoadMyData objectAtIndex:0 ] objectForKey:@"Number" ] );
        } ];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- ( void )sampleImageFadeIn {
    
    //アニメーションのタイプを指定
    [UIView beginAnimations:@"fadeIn" context:nil];
    //イージング指定
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //アニメーション秒数を指定
    [UIView setAnimationDuration:1];
    //目標のアルファ値を指定
    _title_label.alpha = 1;
    _explanation_label.alpha = 1;
    //アニメーション実行
    [UIView commitAnimations];
}

- ( void )FadeInButton {
    
    //アニメーションのタイプを指定
    [UIView beginAnimations:@"fadeIn" context:nil];
    //イージング指定
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //アニメーション秒数を指定
    [UIView setAnimationDuration:1];
    //目標のアルファ値を指定
    _Button.alpha = 1;
    //アニメーション実行
    [UIView commitAnimations];
}

- ( IBAction)clicked:(id)sender {
    
    [ self presentViewController:[ self.storyboard instantiateViewControllerWithIdentifier:@"NavigationStep" ] animated:YES completion:^() {} ];
}

@end
