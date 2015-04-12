#import "SettingsViewController.h"
#import "Constants.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize switch_sound;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    BOOL soundEnabled = [defaults boolForKey:[Constants getSoundEnabledKey]];
    
    [switch_sound setOn:soundEnabled];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)ok:(id)sender {
    BOOL soundEnabled = switch_sound.isOn;
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:soundEnabled forKey:[Constants getSoundEnabledKey]];
    [defaults synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
