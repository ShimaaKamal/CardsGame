#import "StartViewController.h"
#import "LoginRegisterViewController.h"
#import "HomeViewController.h"
#import "Constants.h"

@interface StartViewController ()

@end

@implementation StartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString* username = [defaults stringForKey:[Constants getUsernameKey]];
    
    if (username == nil) {
        LoginRegisterViewController* loginRegisterViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginRegisterViewController"];
        [self presentViewController:loginRegisterViewController animated:NO completion:nil];
    } else {
        HomeViewController* homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
        [self presentViewController:homeViewController animated:NO completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
