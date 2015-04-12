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
    animationView.animationImages = [NSArray arrayWithObjects:
                                     [UIImage imageNamed:@"Untitled-2-01.png"],
                                     [UIImage imageNamed:@"Untitled-3-01.png"],
                                     [UIImage imageNamed:@"Untitled-4-01.png"],
                                     [UIImage imageNamed:@"Untitled-5-01.png"],
                                     [UIImage imageNamed:@"Untitled-6-01.png"],
                                     [UIImage imageNamed:@"Untitled-7-01.png"],
                                     nil];
    [animationView setAnimationRepeatCount:1];
    animationView.animationDuration = 3 ;
    [animationView startAnimating];
    [self performSelector:@selector(delay1) withObject:nil afterDelay:3];
}

-(void)viewDidAppear:(BOOL)animated {
//    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
//    NSString* username = [defaults stringForKey:[Constants getUsernameKey]];
//    
//    if (username == nil) {
//        LoginRegisterViewController* loginRegisterViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginRegisterViewController"];
//        [self presentViewController:loginRegisterViewController animated:NO completion:nil];
//    } else {
//        HomeViewController* homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
//        [self presentViewController:homeViewController animated:NO completion:nil];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)delay1{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.0];
    [animationView setAlpha:0];
    [UIView commitAnimations];
    [animationView startAnimating];
    [self performSelector:@selector(delay2) withObject:nil afterDelay:1.0];
    
    
}
-(void)delay2{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.0];
    [loadView setAlpha:1];
    [UIView commitAnimations];
    [animationView startAnimating];
    [self performSelector:@selector(delay3) withObject:nil afterDelay:1.5];
}


-(void)delay3{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.0];
    [loadView setAlpha:0];
    [UIView commitAnimations];
    [animationView startAnimating];
    LoginRegisterViewController* loginRegisterViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginRegisterViewController"];
    [self presentViewController:loginRegisterViewController animated:YES completion:nil];
    
}

@end
