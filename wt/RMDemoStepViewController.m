#import "RMDemoStepViewController.h"

#import "RMStepsController.h"

@interface RMDemoStepViewController () {
    
    BOOL flag;
}

@end

@implementation RMDemoStepViewController

@synthesize uuid, UUID;

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

#pragma mark - Actions
- (IBAction)nextStepTapped:(id)sender {
    
    [ self.stepsController showNextStep ];
}

- (IBAction)previousStepTapped:(id)sender {
    [ self.stepsController showPreviousStep ];
}

- (IBAction)closeKeyBoard:(id)sender {
    
    //returnキーでのkeyboard収納
    [ self resignFirstResponder ];
}

@end
