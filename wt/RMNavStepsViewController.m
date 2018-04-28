#import "RMNavStepsViewController.h"
#import "RMDemoStepViewController.h"
#import "EditData.h"
#import "infoViewController.h"

@interface RMNavStepsViewController () {
    
    EditData *Editdata;
    RMDemoStepViewController *DemoStep;
    infoViewController *infoview;
}
@end

@implementation RMNavStepsViewController

@synthesize UUID, uuid, PersonsName, PersonsNumber;

#pragma mark - Init and Dealloc
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    DemoStep = [ [ RMDemoStepViewController alloc ] init ];
    
    PersonsName = [ [ NSString alloc ] init ];
    PersonsNumber = [ [ NSString alloc ] init ];
    
    self.stepsBar.hideCancelButton = YES;
}

#pragma mark - Actions
- (void)finishedAllSteps {
    
    NSLog( @"PersonsName : %@ && PersonsNumber : %@", [[ Editdata.LoadPersonsData objectAtIndex:0 ] objectForKey:@"Name" ], [ [ Editdata.LoadPersonsData objectAtIndex:0 ] objectForKey:@"Number" ] );
    
        
    UIStoryboard *main = [ UIStoryboard storyboardWithName:@"Main" bundle:[ NSBundle mainBundle ] ];
    [ self presentViewController:[ main instantiateViewControllerWithIdentifier:@"StartVC" ] animated:YES completion:^() {} ];
}

- (void)canceled {
    [ self dismissViewControllerAnimated:YES completion:nil ];
}


@end
