#import "StartViewController.h"
#import "LoginRegisterViewController.h"
#import "HomeViewController.h"
#import "Constants.h"
#import <AudioToolbox/AudioToolbox.h>

SystemSoundID backgroundSoundId;

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
    
    // Background Sound
    NSString *path = [[NSBundle mainBundle] pathForResource:@"bg_sound" ofType:@"mp3"];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) soundUrl, &backgroundSoundId);
    AudioServicesPlaySystemSound(backgroundSoundId);
    
    animationView.animationImages = [NSArray arrayWithObjects:
                                     [UIImage imageNamed:@"splash1.png"],
                                     [UIImage imageNamed:@"splash2.png"],
                                     [UIImage imageNamed:@"splash3.png"],
                                     [UIImage imageNamed:@"splash4.png"],
                                     [UIImage imageNamed:@"splash5.png"],
                                     [UIImage imageNamed:@"splash6.png"],
                                     [UIImage imageNamed:@"splash7.png"],
                                     nil];
    [animationView setAnimationRepeatCount:1];
    animationView.animationDuration = 6 ;
    [animationView startAnimating];
    [self performSelector:@selector(delay1) withObject:nil afterDelay:6];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)delay1{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:3];
    [animationView setAlpha:0];
    [UIView commitAnimations];
    [animationView startAnimating];
    [self performSelector:@selector(delay2) withObject:nil afterDelay:3];
    
    
}
-(void)delay2{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:2];
    [loadView setAlpha:1];
    [UIView commitAnimations];
    [animationView startAnimating];
    [self performSelector:@selector(delay3) withObject:nil afterDelay:3];
}

-(void)delay3{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:3];
    [loadView setAlpha:0];
    [UIView commitAnimations];
    [animationView startAnimating];
    [self finish];
}

-(void)finish {
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

@end
