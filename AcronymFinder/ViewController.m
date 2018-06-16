//
//  ViewController.m
//  AcronymFinder
//
//
//
//

#import "ViewController.h"
#import "AFHTTPRequestOperation.h"
#import "Acronym.h"
#import "DefinitionListViewController.h"
#import "MBProgressHUD.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *acronymTextField;

@property (weak, nonatomic) IBOutlet UIButton *finderButton;

@property (strong, nonatomic) Acronym *acronym;

- (IBAction) finderBtnPressed :(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Navigation Bar
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    //Status bar
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //Button
    _finderButton.layer.cornerRadius = 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IB Hooks

- (IBAction) finderBtnPressed :(id)sender {
    
    [self startUIActivity];
    
    [Acronym getAbbreviationFor:_acronymTextField.text returnWithCompletion:^(Acronym *acronymObj, NSError *error) {
        
        if (!error)
        {
            NSLog(@"Acronym is %@", acronymObj);
            
            // Set the class property and perform the segue
            _acronym = acronymObj;
            [self performSegueWithIdentifier:@"definitionListSegue" sender:self];
        }
        
        else
        {
            // In case of the error, show the error message
            dispatch_async(dispatch_get_main_queue(), ^{
                [[[UIAlertView alloc] initWithTitle:error.localizedDescription
                                            message:error.localizedRecoverySuggestion
                                           delegate:nil
                                  cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                  otherButtonTitles:nil, nil] show];
            });
        }
        
        [self endUIActivity];
    }];
}


#pragma mark - Text Field Delegates n Others

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

// Dismiss keyboard when tapped on background
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if ([self.acronymTextField isFirstResponder] && [touch view] != self.acronymTextField) {
        [self.acronymTextField resignFirstResponder];
    }
}

#pragma mark - Segue Methods

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if (!_acronym)
        return NO;
    else
        return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Define the tableview data source object
    DefinitionListViewController *defVC = [segue destinationViewController];
    defVC.acronymDataObject = _acronym;
    
    //Reset the object
    _acronym = nil;
}

#pragma mark - UI

- (void) startUIActivity {
    
    //Change the state
    [_acronymTextField endEditing:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void) endUIActivity {
    
    // Restore state
    _acronymTextField.text = @"";
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
